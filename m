Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBE215F7D
	for <linux-mmc@vger.kernel.org>; Mon,  1 Dec 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764571757; cv=none; b=OBty7RaiFDWcAawrlciWlMqDRb3a5m6G6tXzgVGbGiGntWm4QqsZDT8cR2eRlHzsHVg8DQEXJYxmGfkj0bYtu98RUOMSOKW49iLCyik+hVV4vB7iosFsqQ/x43n1P7mplOF4MPJA0IXn+0t2gbyk8fzDfGHidTP5D/UKhklDjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764571757; c=relaxed/simple;
	bh=E7OjqbqS+4mGY4npTVkgGtLx+Z0bKn4/PegCW8SEls0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=be8vWhIOXzFw5Wt9InGEtLnipzTLvMXuxxp4W+sCUm0VZ9UuV1G17JSa8JYTHUJpW3ELenPl5YJzYPMRz1/9IwuMmuAGjmJCKtPWX7HuLUgMv1uoQYehHRL3gY2nJVjgS3tsuOAKO0AKBBBlZvHOJuMj9SuIWZ7whaBN1GL4fCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oR47m0iw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DnuTBIHe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oR47m0iw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DnuTBIHe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AUMnQJj3195103
	for <linux-mmc@vger.kernel.org>; Mon, 1 Dec 2025 06:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gemHNmwMJPMQ6RzPW/H1gwr513AnLQz12AEpe511/UA=; b=oR47m0iwZztUqCg3
	ZgmZBRYLQGhZsQEIaiOZDyg1BY6nHFyXX0fXmM6trez5o34qzpJBPEkTeYSf0eaf
	96uP7pgUu+RO1K2Ok8UbmBhv4H39MA9DcFIXob4bXFpPX/PgYcio12ypiBkU1EoU
	VwabeZ+GYHrQpyKsHOAjPQqAoDnILsni7FjRfDTynyf7pMrGp48c38KxxfSqxItf
	aRqAwW5CSOeZUdFnEBnhpDFiGZ264O5y42lWmdPqkO4xfCU2B66T8WaxL+C9En1h
	D22DDBL4Q6w39kD8hNZJjywl1nuKEZ9GVMiJNGIxKlENI2lhPbd672IYoGCQhpcS
	XQHjcQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqrdykrk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 01 Dec 2025 06:49:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2958a134514so51564715ad.2
        for <linux-mmc@vger.kernel.org>; Sun, 30 Nov 2025 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764571754; x=1765176554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gemHNmwMJPMQ6RzPW/H1gwr513AnLQz12AEpe511/UA=;
        b=DnuTBIHeZudZ3ahhskYrd7YAyaRLB/WzZI8KWs0TpmsW7mnsTw80O5n+vjGNty2tYq
         m9ObIg+J96wcVBdoKuW3eGdKJZxCkZnaW3CqJ5C6KoeW3Lwq/1jWjNc6Eqa4njGd2oLk
         H6pxCW3LPzRFu9xXC6YqCTnGCnqjRG+foikcaXWiyZdtYLKEn50TFgh11Z6CHEzmooDq
         dFe5hIo05xMx6WIpcnPWZMyBE30MNBy9dx5bYiPbaKVUYw1Hj1Nrfeq8F+6VubwmzR0b
         BQ6gKTxDBA6r+SkieMze2Bd3+LYvORqy34/Xij+EbgOVB1Q+IYhJeRbab2MRYv/fMhXx
         sFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764571754; x=1765176554;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gemHNmwMJPMQ6RzPW/H1gwr513AnLQz12AEpe511/UA=;
        b=Qfh3tG9R0HKHRqLljQjrVPMyfD1sLH4LAcna3z2o6xUDSwDifuttkO6RCCMSSeGvzp
         D84tNOAbhCyAKdzq5uCqvwYPOGB8Y4Xi27T/n1WCtvlvmGgfJR5KrkviLCBn5Ahfuwj3
         +K4cgHAJKusjPIaCI5CTK2sxtxq6BJUAlyIB2BCMUGVvJjd5QaaEewiuqPTGaicb7pb8
         lEDDegqrTrJZwKDtggPsVYu8fE4FivXPacdxueRVrr9bCS2ztm+jEfTY4K/Y8+oifGFj
         v5pD93zHE4sVXXIHGeOZQ2Y97LfG8034PuT6Vx4oxM/acYBdxg4sbKDgeFo4zMvGdOl/
         uwfw==
X-Forwarded-Encrypted: i=1; AJvYcCUuSZrwdfB8UGyBzRXxqxO5R22QUXSO43lXbpfuDrqptSlTFZ/EqyA/fggahFFUBjFi599D8PvizFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCd9pbStMEESVIJ5XJu1tLQU6oJ063xYZHO2cGMELnvpURMipv
	hynnZIf9RynRqI8Ko7p5A5K5edYcoCzzYYD8ZE5S4DkoZnOp6Qi63n4I34ge8l85Tlaqc6ysi7x
	YJc1pNuC33YZwV5zE0UtmmRPa87qHBVgQnqbrontDbCizAEQ9WQDV8YWBRQ6Gr3Q=
X-Gm-Gg: ASbGncuFBAxfKH+6mG8VTDnIenyXjvtt3RToMJdWwN529bhsDuDnLXQa3WW7eqlM6du
	iSmHc0lVxGpTFJGphmBEUbjItRYNHW/9dVdtjNQQs39BaH9fkOhxGI8Ko6vzoXkSFIatKoiBZZB
	WF/4TvRfAekuHda4YlBqMgiOxpA7nzGxG6j+PQO3+fbsFvbvc10wEnKYwLadR1mp0pNYP2LhWko
	mb/V5JnyfiFZ52YSDVbJl/6J7RJTCDqkgBPgYh7rUtFRcXmdhU6Etye1v6r4RWXEcinnOYDmRMn
	H0ipt8DK9NF2K8H6vHFn4dgs+o+zFVcQ82vupa8K74rsC4t559Xn941NUWuKHg+zOpWHkeoPT8S
	SvbH8ZClV4RoWI9n/R7utAUBWnDuvEsoIhLToag==
X-Received: by 2002:a17:902:daca:b0:295:59ef:df96 with SMTP id d9443c01a7336-29baaf8aa2fmr238442025ad.13.1764571753608;
        Sun, 30 Nov 2025 22:49:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIipze7/wBgcpTJG7Vd1ABhMvxy6/K9lj4c34zLYEkFy9oY3AG+6j5+ogR9LQTyz7j/Ytkzw==
X-Received: by 2002:a17:902:daca:b0:295:59ef:df96 with SMTP id d9443c01a7336-29baaf8aa2fmr238441685ad.13.1764571752937;
        Sun, 30 Nov 2025 22:49:12 -0800 (PST)
Received: from [192.168.29.77] ([49.37.155.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40acbbsm114608055ad.11.2025.11.30.22.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 22:49:12 -0800 (PST)
Subject: Re: [PATCH v2] mmc: host: sdhci-msm: Add support for wrapped keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, abel.vesa@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251127073048.2759159-1-neeraj.soni@oss.qualcomm.com>
 <20251128175559.GA2000@sol>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <e09bf9d9-a6fe-fd9d-b0c8-5428f10005c8@oss.qualcomm.com>
Date: Mon, 1 Dec 2025 12:19:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251128175559.GA2000@sol>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S4KFR4Vx1ePy0wcjJlirldU5itP4NpJM
X-Proofpoint-ORIG-GUID: S4KFR4Vx1ePy0wcjJlirldU5itP4NpJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDA1MyBTYWx0ZWRfX4kbdQsNflfua
 VRkIMb7TFHleWTQ3uJTP9wNknHa9h+Ii7m7l+bwkhOV7ksHKrcKIBmCAI+9hYW6oLore1Qf8ImR
 zfa5BsUho61fYjL0yNUeO2KC8057Kn5JkqUTxYt3zFDzWK+NFRns66cNNzilZjlZ4aeh+P7AgO0
 u28GCc7TmNqN8KhJTT6rQ0pVePQcMumjDRdDgm8GxNqmfTrmMIJ7QCo4jAxZSxBf2hdMoIDTO4x
 uYCbhlUfzpEGNppY7ZLjo10umabBrXgkWzCy9X1hHh/IZipXN3xoEyl5DSxF4ReWbgwsaZO/Brs
 cqNDHgwj0AcOUYIrIR1ZYPyXUDK+Ih/dWei+vpk+Zy/wmovRCqtiSxdSBoSpnD2vcsOKk0VfVJc
 lFPsOwFcltIZ7sQMNt1D/gUxGweiqw==
X-Authority-Analysis: v=2.4 cv=ed0wvrEH c=1 sm=1 tr=0 ts=692d3a6a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qKc52UxUbR90Cc+7RLwjqg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=90dgnz13A4KOmbfFnlkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512010053

Hi,

On 11/28/2025 11:25 PM, Eric Biggers wrote:
> On Thu, Nov 27, 2025 at 01:00:48PM +0530, Neeraj Soni wrote:
>> Add the wrapped key support for sdhci-msm by implementing the needed
>> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
>> blk_crypto_profile::key_types_supported.
>>
>> ---
>> This is a reworked version of the patchset
>> https://lore.kernel.org/all/20241101031539.13285-1-quic_spuppala@quicinc.com/
>> that was sent by Seshu Madhavi Puppala.
>>
>> My changes rebase it to use the custom crypto profile support.
>>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> Your Signed-off-by should go above the scissors line (---).
Thanks for pointing out. I will fix it in next patch.
> 
>> Changes in v2:
>> - Updated commit message for clarity.
>>
>> Changes in v1:
>> - Added initial support for wrapped keys.
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 51 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 45 insertions(+), 6 deletions(-)
> 
> Otherwise the patch looks okay to me.  It lines up with the UFS
> equivalent.  Can you also provide details on how you tested it?
Sure. I tested it on sc7280 (kodiak) eMMC device and will capture the test steps in next patch.
> 
> - Eric
> 
Regards
Neeraj
