package com.ugotfilm.data.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ugotfilm.data.dao.DataDao;
import com.ugotfilm.data.dto.GenreDTO;
import com.ugotfilm.data.dto.MovieDTO;
import com.ugotfilm.data.dto.PersonDTO;
import com.ugotfilm.data.service.DataService;

@RestController
public class DataController {
	
	@Autowired
	private DataService service;
	
	public DataController() {
	
	}

	//영화 정보 체크
	
	//인물 정보 체크
	
	
	@PostMapping("/save/movie")
	public String saveMovieMethod(@RequestBody MovieDTO data) {
		data.setMovie_id(data.getMoviecode());
		service.saveMovieProcess(data);
		//type 형태 확인해보기
		//object, map
		return "영화정보 추가 완료";
	}//end listMethod()

	@PostMapping("/save/person")
	public String savePersonMethod(@RequestBody PersonDTO data) {
		data.setPerson_id(data.getPersoncode());
		service.savePersonProcess(data);
		return "인물정보 추가 완료";
	}//end listMethod()
	
	@PostMapping("/save/genre")
	public String savePersonMethod(@RequestBody GenreDTO data) {
		data.setGenre_id(data.getGenrecode());
		service.saveGenreProcess(data);
		return "장르정보 추가 완료";
	}//end listMethod()
	
	@GetMapping("/save/moviechoice/{usercode}/{moviecode}")
	public String choiceMovieMethod(@PathVariable("usercode") int usercode,@PathVariable("moviecode") int moviecode) {
		service.choiceMovieProcess(usercode, moviecode);
		return "유저 클릭 영화 저장 완료";
	}//end listMethod()
	
	@GetMapping("/save/personchoice/{usercode}/{personcode}")
	public String choicePersonMethod(@PathVariable("usercode")int usercode, @PathVariable("personcode")int personcode) {
		service.choicePersonProcess(usercode, personcode);
		return "유저 클릭 영화 저장 완료";
	}//end listMethod()
	
	@GetMapping("/save/genrechoice/{usercode}/{genrecode}")
	public String choiceGenreMethod(@PathVariable("usercode")int usercode, @PathVariable("genrecode")int genrecode) {
		service.choicePersonProcess(usercode, genrecode);
		return "유저 클릭 영화 저장 완료";
	}//end listMethod()
}//end class
