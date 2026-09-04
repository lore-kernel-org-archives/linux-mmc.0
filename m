Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086E4477E4
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514899; cv=pass; b=e0zjXnSmrxSCKrhpKsYZcYitViNOqinsah4SLXiJyVCV4fWhZ1ogV1pPIvhjYMVY7twEZU4SJ1+2qPwEQU/pprCNzG04Ln6JXkwrzzKPcHduvmg6rZHWiyFYsRz9xMY8cBJluG3fWP19Cj2vlkGh6jXN1ukkkzzs1tbveQJSfyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514899; c=relaxed/simple;
	bh=aeIbZ7Iqe67MQUbdL30yfOYMS5DGGUDI699nLrKwSTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSRNcTzD0z41AA1ZOXOfa5zGF4twp1Gbm0MIz2S7Ehg9u4v3vLATyZ/fMGZlOqhWsxQrUSljQJTEtpqmuyJChw8a9zKQDVgls/RQRZD4bYdu+MA4ZcwdCvnC8oRQz3RpBATPcSNALkyq8+KH3smg2/jPUrqyazK4JLMP7L1cMRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i72Z6a9K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A8Ihag5g; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i72Z6a9K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A8Ihag5g"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mpFb2430144
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=; b=i72Z6a9KXUf5KnGC
	BQonw6JeT+Vjv4bONkiN5R/yDVYIy4owVbuOPcViQ2rgdsioq3JFpI8fDPff+J13
	SBrDNXi2c6ZJBU/55j5rdEWi4AH2gMUk7myZfe2KJ7yq/lQENXcTlmOrHymAn+RK
	1okxZnHiy9mF9JRuYYCZeD69q+Fsnt1HOUvM54W+heRsuAPKud8Rx0TmUng+bLcz
	t2NTi0363Uz6ckoyx2DYmRrDG/oKK0BRouJUiOBIx2ctjEScgjqdClPHa9c15Ht7
	X0fE0Uykud3+DQLIg9Lli3VWMrgxQ3S3RLfgdNEwORppGHKokMOvEmpLAPtM82bm
	+g1k6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfk921m1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:41:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-855f662439aso1516860b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514892; cv=none;
        d=google.com; s=arc-20260327;
        b=EIe7NWEyxCKEBzdxr1jbSunpMdEq60MDtVhQ7MAEx7J0FcvTzjGS6xh4+PpLs8v0yj
         5/XgdtdRrGmeJVa+f8Wp2lKqn/r2s2Lg7mXHQ/huWNufcBLsgPkMsrt04QM6uXjfqK1K
         I2qDm4MXKTlCrsoN74l8di/oI0as05XHpyuJ3/vMN5ww8rP3Kjwg7iPO+huGtRzaO/RZ
         cReFQZuxjfIhLmhrHXcQM5IhodWtebJfobBzzY1QA63RXYG6yYesddCd0bufCT2+nqBW
         oDr1BaKDA4qkoTgl8xVGEYx+eC42tAdWJNJy5D9jkS9bCQvDP2UrCSNCdijOQmu/6GlM
         LjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=;
        fh=7DGXHs0hNvv9aF8+uIYBoUhrn4YGYKRZJ12XbJJT56I=;
        b=D3b5euRdPO66ITh+y+MqKckTig+P35tIEL9SPssJiWEwiL0E1kBFPafIAelqtUzH36
         nWJHuod760OYWWLmdJZl7piB8+AQAKFOGfVVHvjMph3U6d/OuExfCndUba4fZ/gMALBZ
         DhrUWQb4r4xbO+ba2J7wFQ373RNoJ3tR5068klORTNQBMwmXDgWs3PPObGZt4/mkW2RC
         kAx38iuf0Fr+ecFizjmfJqxK9gfX+V3HCUJ9teQ8jPGxNNXyAklgeb8ErrCPq5V+D0XT
         8sJXdcJeJYMisfWKTTi7O5KLXK/b80eveoWLSvcdm4VF8aChTxAn1PK8nGwtuFw0ddxh
         CiaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514892; x=1789119692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=;
        b=A8Ihag5gsM5mseZmVs/nSzeGC4ZbtJHkUSDmWjug3v+SEjloN0mP/eXWqtyUgqm0wG
         DP3BD0MDZgL807UPOr1apyvtAIR+IYCOsyAHf7lDlap2b4UB09td0k+YjmIF+w5aGF5b
         tZDX99hCfyyaBsm9FGiLSEVZe5HmXJxwCkdrDfny2ZTJEtONQQPSp9rC5YihI/zuiRC7
         CnAqffipYLInuLwDrsKERAh5GUkYHOn1KiL5MB5v61r6cIUJPbIfA6C6YpC2bUAFnXai
         vMmcQkmibB4Ee79xU1b3/7LCdvHUflQ5P1DHjKDfzOg0DYEyLweidrKvwc17pT9vDWzV
         nP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514892; x=1789119692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VI7GobWclG+P/LAGHzs6kL80cH1L+yzTiHPraa21oAA=;
        b=eT2fhh3jljO9f76xL26HqeiMcGipzeoPq8Byi8jDE6surPasEVwxVnnyF/ol3Cgqsz
         XIbuQfBxMNgbKJU3nMbWb7+4x65paX7Gj3JXySBKnRfgsOYnhFUrINe1p4tEW7husBYI
         PrsI+DFhzgov+AyKjmw9NBVmEcavv7UziF7oemdIPhQXdhHXJgxjRHWgZjRvlxKJ8lKn
         vZqBGjgqaXI+dYpL+mfHS8Sk4zSg/+PC0uh1X9L9gCjTltm0LTXALhFsWP39nZZzdMYf
         Pr9hwUGh5vhKsJ+HooLrqI1f+EYUtv/P3tUM5gVBD5D1+TZqUn1SsyoEQ8m6tKbZ+lU7
         ClHg==
X-Forwarded-Encrypted: i=1; AKwUvBxQhCuJIr2u6yLp1L+X+jd2icDJQ59QlOkndgDUT5kvDQ4hGqzRN81JYkP35q5zGTFCG/0KB8IRffg=@vger.kernel.org
X-Gm-Message-State: AFuF++nFiNdtTedIzttZpXPh+d/ebqaFDOrWQnt3yLiqcPXmabgGj6nV
	uic5CLjFpe58BtBszJDOT9gJqZB6xDbZa6wk7sVTBl42cJgPzmNQGq79ZoaI5fUGuL5yKUjI1ho
	G1HIfbK+ICY0feBhRh2QFVOnXxPPbLOt0uqiXNuHXOARNBXsLmYuVg8G+AjrdrhQWx1qAVuIpHe
	4ZK1dWnNUCE3krHsUGwnBioeCr8iHYbPMt6pFDcA==
X-Gm-Gg: AYBFou3w9NX6+0qbcHHEJ3gBrj8uDMYILclYLetj476VwpQJaFSBcvdsHDS06b8vNeE
	LUlvf6QPmbmuCrT6W+m38YWKAoTA/WN3Y5g4mbOhFgKMozdi4YZyZLfP+Q8q3XxGTu36FPIX+2B
	/+a/Aw9Q7hAoGUcJ/1oQ9HPROR0Tte3reDyg/27nwNYQrQxI5dltadfkWznQ==
X-Received: by 2002:aa7:888b:0:b0:84f:dfce:966b with SMTP id d2e1a72fcca58-8616a06b9eamr5822381b3a.8.1788514891644;
        Fri, 04 Sep 2026 02:41:31 -0700 (PDT)
X-Received: by 2002:aa7:888b:0:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-8616a06b9eamr5822324b3a.8.1788514891229; Fri, 04 Sep 2026
 02:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-19-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-19-david.laight.linux@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:19 +0200
X-Gm-Features: AcwNN1XghJRFBri_1kHjfvi2ey89ABXgLFgvTbim4Ym2LDpNCA5fwc7QdZp97mA
Message-ID: <CAPx+jO_btBTkL2Ph9rM6er8SZkSqOB1WmuHhtr5vGBXtwcWxRQ@mail.gmail.com>
Subject: Re: [PATCH next] drivers/mmc/core/sdio_cis: Replace strcpy() in loop
 with memcpy() outside
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX5B28TSQRQo59
 QY5hGggw8aSLbnEpXnSZbauYhZ+r419cnsVbCqTCTVJnz2tpvmsKfdxQw8uyluArof6Uw0ZG7pf
 WXEnagxLcxogbfO3nH3dA/Xxx6a/p31lovj2vkxS/UcmSFiRBHezDRjm9PU5DoWAttlhKyAOOS3
 RwWdisbLW7m7omdfgMNbfRgQ8iJL6bm/MnhqsiDAzcYQ85H8In9A05i5ES5u4B4I5hRxd/HTV/0
 bztT6zxAG4IeiagRXq+uCHwqz+cdN9S5vBNpART7zzFFma3JCdpDLgKUskI0ACjZIvxacwG1zH+
 ehrA0UCGXubtRgEOpc4hzIPxPTvzO/OdCJz83O6r0RB89cCCVn2XBQ+82FKVa6jdbaWUImxZMFC
 FWcEjles2g6/KniRSwY/xm3aBB278vS/PCwqwGFcJ38uDucmP4S+1KkyD/NMPbwfW7VjTiEZvsV
 zwoo6lgpAwiaN1R3Y7Q==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=6a9a9250 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=_2Zrk8i5Ywt6DdIg7-0A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 4W1VVPfKqg0osBdEPguOf9ocTtowDezN
X-Proofpoint-GUID: 4W1VVPfKqg0osBdEPguOf9ocTtowDezN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX/puNdzdtUaGN
 +cMQoLCJKVLIHepu99rNHLt8vDWiN82hsd9VW0IT6zEyFW5+SjEBdKeClk0pzWee24ReGqE1eGz
 VY+0xFzCm9R+Q91e4GoRQa4dDQSUpmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Mon, Jun 8, 2026 at 11:55=E2=80=AFAM <david.laight.linux@gmail.com> wrot=
e:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> When copying the info strings and generating a char ** list copy all the
> strings into the kmalloced buffer outside the loop and use strchr(str, 0)
> to find the next string inside the loop.
>
> Removes some strcpy() that static tools might think are unbounded.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>
> Note that all the changes are only compile tested.
>
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>
>  drivers/mmc/core/sdio_cis.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index afaa6cab1adc..0b818cb478ce 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -57,12 +57,11 @@ static int cistpl_vers_1(struct mmc_card *card, struc=
t sdio_func *func,
>                 return -ENOMEM;
>
>         string =3D (char*)(buffer + nr_strings);
> +       memcpy(string, buf, size);
>
>         for (i =3D 0; i < nr_strings; i++) {
>                 buffer[i] =3D string;
> -               strcpy(string, buf);
> -               string +=3D strlen(string) + 1;
> -               buf +=3D strlen(buf) + 1;
> +               string =3D strchr(string, 0) + 1;
>         }
>
>         if (func) {
> --
> 2.39.5
>
