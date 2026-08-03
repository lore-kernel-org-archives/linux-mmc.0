Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53742CAFB
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780612; cv=none; b=jCZ0yhMiWRSTdWQDzU1enVMunkwk9swWpNZDPm/EDv5GgRTc6223rPCDeJxIOQpEb5LAs7pouNZdu1K/DueRO4Y08QWbudQHCL7dgJrOQmgNFqQHF4Xkm4CEHxiiWAljBSYGe4EG6wycZ3uJI6QApXoJW2PXLxWG86uzjV7z6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780612; c=relaxed/simple;
	bh=YE4PLMf59Dg/WgPWTXTveF3QF4QN6v/6/VJMlCMeQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaCQw0VhBpOboKW2WIc7TaZoDfJxtRGn17onRQiOB0KMAX+mWfrpB5Kpk1QCiNuARbIzPQKPuOBU7kF3sU0hJjH/EhqQLBi2Qf4SuSSPCc9JQ3NGkidsaLDeTCUf0fW+LBojx79QQP0WCz+1btAKGKsLLCfaDG4ebxj0Dl1Bkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jm0LZQGL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KrMjkSev; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jm0LZQGL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KrMjkSev"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673H6mvl1534540
	for <linux-mmc@vger.kernel.org>; Mon, 3 Aug 2026 18:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=i5R0f3/vC2IT0IYP8p2NBJ0/
	aZ46W3TJ/3OnfruU5Ds=; b=jm0LZQGLX1bP7B1rGXB5jWUEvlPjHIlWEWJHtaXS
	51uwzJthlakw+msQNG0RJYE5nUuCCbnPbyVJDbf0kLtEo7dqxaKqAa29Gwk4Wjj4
	Xmske1+wVJrmhEODBWn3w6P258zkwai6G/CGmQAiTTkE+NkgJI5zzIjPx9UP5BLP
	Vpx+CuVgtazwU/Q7gBf5GWz42jxq1AnOEubfXSgtypBMN0n5ONh0iAzZ5HN8zrcw
	fk28ZXVsMyrRSv4SZ3c9LDL69xBUpNk8owha5HKLCuvEMz2xf6Neije3x+13eHtl
	yS22IxNS7dSJPPFX5N8rR2lMO29w2usyU7wrWcCap4NxEQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3sg8v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 18:10:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5283fa0656dso2209961cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785780607; x=1786385407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5R0f3/vC2IT0IYP8p2NBJ0/aZ46W3TJ/3OnfruU5Ds=;
        b=KrMjkSevKfUYFw9CpF9JEQoVx6Oyj0N0Z5sBq0zwbkpSICJB7cjyLMCSQ2YVZiur2z
         m4cWyAq45E6EjZYJ08JDu2iYisBG8sBjA4UEcCWMrLdfTqKcHD5htU59t+qPxXQCdGQ8
         ZwFj+4VdoyVglce2RLSP7sNbkozrLJjuUllGb8A/MPkeYTl6pgj5+qUnjXgYY8WAR3db
         Zfa9sBlen02uCnzsFGM5R0dD7QLAIx3F/x8W2thzDEnO16rzJDy4QtOYiTCcYt5DJmUp
         +ggu+dcA28parTyhcDaXQX/XqH/bmHUHOhV4Bsw3DIOgsWomQtWI+bK2xDp9sGI/ViXJ
         JM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780607; x=1786385407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5R0f3/vC2IT0IYP8p2NBJ0/aZ46W3TJ/3OnfruU5Ds=;
        b=o8AAs+2rBj7RZBOsBrQDOFUSYjC3E3KnMCe5r9SQWusScEhkvpaMMilL5Vdup6KNiI
         jxKw5SN1MkjDQwDSUW8K0zd98sW29fX/lZkIcutOno4w4J9AGdz4K3VsH6o5l2eVAyQQ
         bA48+mIEc3vt7aO6pHgMC47UpOTsByIIwhgA86F3ESVmKBBp6iQiY3JCLsx8p4IUdtaM
         9wvvxq2UswDoU3v6JL+PVQm6T2rFrDjkg9KdK+iJVnnfBnOG0Bv1hodfcZX8coCsq/1R
         EpcU7ktwzTTrYYuTd5vHmTTOfTqghxmwtAqs+A9QR1dJZgNllFHSxVd0MHNoJbg23rP7
         ymSA==
X-Forwarded-Encrypted: i=1; AHgh+RrBUgINwCEPl7CAr10hVjsxbjWIOTk50f1A0zCBhhH2ebMNtCIwf2/BfDaA3g5NJ3g5kkj09gByYjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXbsy+XhHqM0xXrmF9/PiVL2L8AQyWmlqVDRDuQmJjIz0slzO
	tpJEuuXatFo5eK2ykhZvRVmzjl+udc+eEdJcS7BLTORmt0cQNeRm9yZftyxmTwnQnKjibPG0/HJ
	d4/HU+iVPcJCQDtT+wrh8+527NMSSq5WRX9fuPNarFokICMZZjN0jThK5zSYSBss=
X-Gm-Gg: AR+sD138sQul3X5IG7TPopeAjMaQLAkTesE16vti9jKOVaLsB9rOJ3yIQB/0HUmJidT
	jo0AIM51tWLf2zQmo+7WIh6lZDD8bN6KrRuZvgJ7C/RIx0MoelIo1bDykHdN5vhM2i7vVD5IIxT
	3ElKCPZWBXP8FgRYN9eXu2+YEFFqmjznxL8YOPs7OUQYR5RV9l9hLCKNVMz0KsAuTv1bRyNXrgZ
	gPlC0a9I4uorXtNyqGwr8D+phH6rC46E8ICTghJKRE7YdVsvFTIFkJSBlGsiF3/TfzGzlWQ58pz
	2c6D+8cT7nTNgylZhUDOWlVqmdIC/Q7+eMvCf8SNfboe1I8NH/z0u9A4Wb5mV3cVXkFmnptWyUQ
	pYb3g5/MsUgtpMER217gV87JmGXRi9qSDbrliqfQl2mIHrj/EEP4bJT8Wd/uscPUqH0rT2kvpMW
	F082ynh9SZqL92xg==
X-Received: by 2002:ac8:5d06:0:b0:528:1bad:a2a4 with SMTP id d75a77b69052e-52cd35af1d8mr10774921cf.15.1785780606749;
        Mon, 03 Aug 2026 11:10:06 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:528:1bad:a2a4 with SMTP id d75a77b69052e-52cd35af1d8mr10774081cf.15.1785780606213;
        Mon, 03 Aug 2026 11:10:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23c46c4sm2125337e87.17.2026.08.03.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:10:05 -0700 (PDT)
Date: Mon, 3 Aug 2026 21:10:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
Message-ID: <stu224dgiay6mau2enqyf27m54laucdzqaudya6wxcnm7ldu4o@omftbvyuvmqa>
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MSBTYWx0ZWRfX9bOt3WfQJVlp
 m00PAGH8qj8dqQonQQYSBkZ/OhdigrgeCsze7JAA/GPaMrp0tJGjVNQnfuAwbw/SFhUZRWaylOK
 g8VUw7SnOGYMpMK9Ztjysf+9kdGA2W8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MSBTYWx0ZWRfX6oXz6HjkTgTX
 eeAZVsve0p0nuCy4+vgR37tIN9dCYl6JxZ7/OXbYke862ME2rjvm/+s0d7pD/A18iSv85UtOOrZ
 3vrvRQkNzPog6c55yFwGNSF51mms0WBhaoKKB5pOZmb95INg/HPPeeZ1mvctP29kPYTFRuGMTTl
 swh18qzuq9eKtluGhEinTkQXYwJ1qzDsmrY67N+2s/HNsd03zH3IhK+9ayYihmt3bz8EgyWU1FJ
 QZd6UXGjxdCZoJ/bn/I2SMN/cTCESP/KOEf4x4UKZeFuzfWEef6fwxHxI5OWqhkyOmbRIfS4XzQ
 j9I0NlCO612/XQE2nhrkkmN15Q7WzDD4gJjgrYiYQuj1RKlf7O+JQTX15iveLQIPf3XJ3BhM4iH
 f7zjmHlZRRQHakQfmMboVS/mOsp0FRsncOIAIS9YQw+CDlKoeJiIpABKtgvccApIMZKlJ+CpIXj
 LnVyLQUpz1Y/ggC9hTg==
X-Authority-Analysis: v=2.4 cv=Nu3htcdJ c=1 sm=1 tr=0 ts=6a70d981 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=M5MO2ui-36myvQaaUmQA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uPc2b5aD7U5o0M3bUzcDJoslqIk_F7DK
X-Proofpoint-GUID: uPc2b5aD7U5o0M3bUzcDJoslqIk_F7DK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030161

On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> 
> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
> needs to be restored when hibernation exits. ICE keys are re-programmed
> during sdhci_msm_ice_init() but it may not cover cases where the
> hibernation image is already restored.
> 
> Unwrap the pm ops and use directly in driver to add the call to restore
> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
> same state as before hibernation.
> 
> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
> keys is not needed during MMC runtime suspend/resume.

Hmm, if there is a flag which controls reprogramming of the keys, why
can't we use a default and make the core reprogram those?

> 
> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
