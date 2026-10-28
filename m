Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207701;
	b=d5SePpDgTaH9mheKIwH3QBbn2cDO7A2bKIo6x0IO7nFXXsK/NAcALefa1MNkfuOqHA36
	 6kwtNwwjKRgJzGNGXmApVUSMb4PyRDx4OYI2SzF3Ul3Q6u7uL09VDPXbJQj1ZDkxk460K
	 isUhMu1smWSaka7MEmAUx6r5Ua4pNA43Zsl4yLpi/IwAUMpTYn2S+slcXf/gm+A1XPvuM
	 kID+aBqLqxvRbcASxFXoHu0DP7/ZE1QrzdGODmon3JeBPlBlbSHodrU0A0V+RcwjcSpEn
	 g4ezFcvul2+lQVjr9C0QrBPDFCI2ZiB98n6kvG5TH2VQk+wo1Eg6zM8IKGLDOBxxang==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207701;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rPkEKa8G376PmWlqG2pXdXODHiWAvtHfvGLQI2zwKrA=;
	b=OkqRlfBtjxoplJAK9KOdzwo+AeZAyJp98LpaljIQJzq2c1oKfZQzNZh3NUD1USJ2JVeh
	 v3JNSB+La9VdVU2qWZsoyKP/a18zDBaEdiEhdGSvQNDyCqvapD59NOltdbwjZoLDEeuuw
	 +G0lmPrkuhkp5squ3XtO/Hh2LLIThE7EUWW0b9NawbZXRj0GIFrEkWbY51WWOnEuWwYSj
	 sEPnA1NTRwuYynNsmuMQ6GkFaVjBBzT12uDQILiQtZkSrH8YS8waip7DLZZj6oXsj61sL
	 RgHn245PIYJSOKXY8sjP2d4Fv1gT+ODKI90FcZdVCzZh3bkz+ekqSu3AEvDwCPQyQjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p3etyJDa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="VUkP/vvh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14B606A339
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B14B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p3etyJDa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VUkP/vvh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFB5Qr2070782
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rPkEKa8G376PmWlqG2pXdXODHiWAvtHfvGLQI2zwKrA=; b=p3etyJDag/XAgjGy
	BMSAyAOS0Ty8MRK6hiM0ljcdW/0H25SLDCssKgl7Yf1IJJmJ5b1L7hz+Wtp8kjbm
	4WxLxtrj1ItAqRt2S7CWXxh1Me2X8WT1BXImAwqDAD7cUIoC+cuQbGFS54PK5rZ/
	yOPghN36CTxg5eUbotSM1EzhSSUGWOyGMe/dkTiIaF/8R8/6aWVjR1wGVHZxHJWj
	9tyvIf3YULOuSNcS3mF1lB/CaUf17CJHP7QIn62VctPZ3P07fhJyT6YFfsZ6pIKV
	uSJZkEsBaIFL+5pAM8YZM6rInpeIyYGeoZ0vh90R2SiTIQmzOdMr5jSFfle5Q7Xj
	1hvi5A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk7g7kdvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a065e2933fso1513213b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207699; cv=none;
        d=google.com; s=arc-20260327;
        b=pgDWTAmdwN4agZtWmz2xUPMnB/LwkzjZlJsBzf6MbvISSbKj2ipeJa+ABagMuzxTXt
         aId85BK/rBoxLnEe8LXNDu0SNkEp/wCPB6ZhghzIH5Eo4t8Pie1o24hNo3sKJ1RgtzIZ
         knbuFS9BtUt34fU4mHFQj5xOVtmmkGENMEg2GK2Hk+pbL2apouEJf6jhgJ6nF80I0qwO
         scX9VPvJRKMSKvwByDQDULtnxZ1QbjZUcxE+DeUACGw0ZkKFKfa4rcvacoKklsbqOARx
         pnq7aAVifhqJsiKzIZ7xjwKEyz8QBrmBD35hmU841LXLRHRKtx5mBSgmknHqSgZaev5C
         sO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPkEKa8G376PmWlqG2pXdXODHiWAvtHfvGLQI2zwKrA=;
        fh=LdJPQqof+uXcRHba8Z4wSKaaTm3+aNPQOVn7MWB0Mh4=;
        b=YV4I0VGLzvh4VUSAnUTXzLGz6HfQTjCWTo0ePzhK2K3rc0Oo8+aQodCsMfAkfWnWqP
         8EgveB9SjIVnDkvQA9iVZbdAz8FdIk8iCdR/aUNC7FZ5fjmvpOcwb7jRaZpkFv3zzjpa
         Fdl/tXfXWHv8aaSZqhVijtvzHb4pkoU6wP5WJUgCGGrGdXSWJCDrroUFiVPpaUtuiJwD
         5QoQE4JMtWz5JED0f8lVt/XaJYFINDriYyPDU624n2+rTEbRn3+jXDhG7vIggmkYM1dE
         c1bSiGIAIuHXixB8sE4BOFJLtCHSr2515uVUlEA6cX08pAdY+mX0rUc/HgDnsZhoEA8c
         PIhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207699; x=1793812499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPkEKa8G376PmWlqG2pXdXODHiWAvtHfvGLQI2zwKrA=;
        b=VUkP/vvhHskiBBXwiyDGwppNgnMJcbrtsSovXE4vk8jFPCuxmkA+9cVRqqBDeYXK3T
         Z/p5qy1BffBoXCtAm8MwzdhMB4l4VvMJsqYc2rue3AEYYdB51EVJxVSBeaz0xeEqLLUi
         oUVIZUUPPNKBSqpiuxY0So1FFZF7yIHTsFr+mki3qJo2LEU/IC58oIBZBJCjX65CmcCG
         oPH9oixktiDPucaTvhXG+3/c2J+uuQS+NPhETIJ/nhSMha1ETQDaXA7Devr15b/Y/qgg
         nv8m9sdpHx+QTBXzUuRUT6q47OC1JR8e2NGzneLzJoBNQL+q/6I3EDRMWEENPAPEAQsi
         f8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207699; x=1793812499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPkEKa8G376PmWlqG2pXdXODHiWAvtHfvGLQI2zwKrA=;
        b=bmiq/82B9f4eA9Ymy39o8Oli2P88dxZQ522uPGcLo7iOrFdp6Cb0yKmbdTfurYaywb
         ItjwydIdGod/ovjtk9jg8gT7+3iohUAiqWB3Set2XBXi6W6+jqPMQpJYzUfru78+m2X4
         85YIX7GaUt6lj1Zp4tbnD8OzQ6/+A6IORxEu/oxuTO9QRPkjhPRkN1eDUIalp4cC7fpp
         aWbO02gow9LPGZmDtDlcfdywGQXkq6YQPI+Ykg5G4aRHbxk/3tHt/9zZ65BTwva2t+Wl
         8TDar9iP8eZF88buXEhiVvMUdJqzqJxUB8dZ+YnKYiOCA2fKIejtLXFiG8qSQlVZ6yMc
         VJYA==
X-Forwarded-Encrypted: i=1; AKwUvBzvPbNtmWgy3sSwGWQxTrRKPET7FGJI59U8ck4xpRJ8zes9pwk6wO6j4t/FrsGgHvrF/hT2/B+Cgeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVSW2kZuxok35AULEMQBtZ0alwjNKSrFhErXC2xuThMezMDItd
	9mMkQqgPEIEyxdz3yBMVAE75YS4X8dACf/Upj+SjRlasY+jZxoMRxd+R16+2q634KgTO6zH7ipT
	GXX9U9XMpNLkaMQ+JiVSEmj8I9t1DezEn5vfZoYR3uJv9hzyTnX2aZlPioWyLAOkFQknl+/Kzhw
	jsLoUQG18GdwDouq3GBIzSYzz1ha9QDezzi36fYA==
X-Gm-Gg: AYBFou3mO4ZkpPyAT2IZByPz4Nb6sjS7uxpGaSkCiYlGWcTRqSSbjeI54c9wHoWOZZ9
	55WhPFW0e21oRWUECbiQppb8jUGBxecnTBKWWgwcqP8hrYo1qm8hVeokb7f78UZmH57fD4P3Q2+
	OXfOoZ8m3SO3G4YN2ibh2l4ro5mmxiLn2LEKsr7PbzNZ6JJZLdqkQuOWoLVA==
X-Received: by 2002:a05:6a00:12dc:b0:899:f331:9bd0 with SMTP id d2e1a72fcca58-8a6e7acc641mr2396645b3a.43.1793207699204;
        Wed, 28 Oct 2026 10:14:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:12dc:b0:899:f331:9bd0 with SMTP id
 d2e1a72fcca58-8a6e7acc641mr2396627b3a.43.1793207698757; Wed, 28 Oct 2026
 10:14:58 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:42 +0100
X-Gm-Features: AclHuK-EHCrebKy6iA5Pald63UEkwBTXlyUZe83As0cMNm4BVTN5kiHvHdG0-5w
Message-ID: <CAPx+jO--dmN6uxHXZbUL3prESgvts-QwGoNPR48Ay4rc0gOj1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Let mmc_regulator_set_vqmmc() use ios->vdd to set vqmmc
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX52hahAKtlCe4
 uTQV2+gF5uJcy3ewxMx+z/U0CS4wQbpS/A0Z2Lk32cHx4m0zK9a5mvot7SN5ieD6miY5+K+ANDL
 bPYr3OB0ZaKUGAMhelQxGVARXdB1GrE=
X-Authority-Analysis: v=2.4 cv=SoIFe/O0 c=1 sm=1 tr=0 ts=6ae22d94 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=s8YR1HE3AAAA:8 a=Qqk-UaXwsSa3U4-5TL8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: DmBe9WfXx2F4ESG4sNotIZTKnrhjNZkB
X-Proofpoint-ORIG-GUID: DmBe9WfXx2F4ESG4sNotIZTKnrhjNZkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX+vkg+HH2Q9zZ
 /1bAMsxahzoF8MKVFgSNckzKttZTPwweUeKnVjY54ZpWIhHUSMY18Mq0S7z4iugMoPTibUr6eRc
 aYP2WlTlLm8uST5z5IbEr70GGKDX41Gw35q5PNRFdFBy6O13wxdZ5jJ0YNx2G1s8HFa/si2ZB5G
 qscHU2k5jN3V+ag1wD3HmRp5aknf/60sVC8nOGGmtQVz6Xxt1j1GTOePvBeyDBwjqX39/+i3hbC
 eemEo0yi3i6AsM6YXZQNJ0m40V4uZl4HqCWl2AFZznALvfE2fL75IlQRIeaUVXMcYS2uLLB0c6u
 O/STCei57X0LenmWHbNmkkBtTbSaNKnma+MnuX5nCa+V8hkcHOax6iquUFQtzs15ISPsARuts21
 7c/kHVLRcJs7OQBhQPodD5oKW3+7mC01Z5KrgOp1bvWHZHuOC+4ZVIIz+F1bTp99OkFSuAIlcEH
 wBUDfBnCP54K7TzecDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Wed, Sep 30, 2026 at 6:33=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
>
> mmc_regulator_set_vqmmc() derives the vqmmc voltage range from
> mmc->ios.vdd, which can be stale with respect to the ios passed by the
> caller. patch 2 uses ios->vdd instead; patch 1 prepares sdhci-msm,
> which passes a local ios with an uninitialized vdd.
>
>
>
> Shawn Lin (2):
>   mmc: sdhci-msm: Initialize the local ios in msm_toggle_vqmmc()
>   mmc: core: Use the ios vdd when calculating vqmmc for 3.3V signaling
>
>  drivers/mmc/core/regulator.c | 2 +-
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.7.4
>

Both patches applied for next, thanks!

Kind regards
Uffe
