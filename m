Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790628;
	b=mJo8UDmGquSOisAEKucUcshYWZQYY93+H3S6kiVzqXqcFxx0eejVVKr5jPqYXXsJP41Z
	 7SKdp54D2mnh4kEgWlyk92tZRnaZ17jYoVRBzpsg26JtQv6tSjZ+rxaNy18RVstJaz6/Q
	 RcvjDP0Dm9vJQyAqhbTXX91raZcXsB3Ct0wV/HuaIYq1rfxZcTyzPPHMA9KAP5EHcvlej
	 86RdvEfHsAnB5vSbRQh/NTaI0svKkQjj1lYMmAO1jsSu1hD9N3zLO4g4Dzen1/6YDfKjc
	 Y8D6ggm3QrS4+JdTrA0Ee1B+Is5X+nJgnZpFB8X9pXcmbUHxRMFrWHThBGaSTqYab5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790628;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=S1GibcSi8ppb2aibwn9jnQWyPdpPCwtJ3CDbi0G70gY=;
	b=PiCCLGr5hRq2A0j1lTpDenKylweYBM2wkZAuyZuECck0au5ghzj7Ph15omV66Crh9Znp
	 2mbth3wV60hOKH2LVW7cVNYxsbqSwfsczDkwbPOHiU8X/isYfZXxcw/5E9TTBSnGX1aQM
	 YF1vuga5L0iy+kZmRmMu8ke2dzsHnzotkvrI7jCQCeVsF0qib3qGzDFsNFJKo0+28W2sG
	 kB44L9iCYg48U45B6i8Gx3TU61WEFEgZj2CWdphemxY1R98FojxrlUJ2zS3vZ4aoquJ1J
	 d62SKNYx9WWg5xbfeat6tws4Q03cpfF7ncv+k8Ji5BTv81dKx0+PcL1cSmCHNX2iR2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p1N9tj7O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwFqb3Wk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E03606A338
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E03606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p1N9tj7O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwFqb3Wk
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1PLP1462702
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1GibcSi8ppb2aibwn9jnQWyPdpPCwtJ3CDbi0G70gY=; b=p1N9tj7OkIZ1G7Pi
	uCg15YplP8iczOFLY7h0M0D1C1x8hIhVCnW97uAA7laN4Sbi7jay9LIIVP12R1MC
	fujQ2LaKRCRMFF0P7+hkBgXjloYuncHBxdizzOL1hfBYteifZqQkNAYp2LSC6qYv
	PRI4RGBJUpWPDVG6MZHMsao43P1J2QnJ/bErQqozTORTFTPPxyj8P+l8Bw9O1lY9
	SoZHzAf5GH4QV2UNXOnHh0JZtxTgPUtFVzoT/VyY2OZZhLw3oeoZSmJewIZo8kad
	C9wqvRivDmdfAVTYJ6XdHMl/mILtPMl7LUg3CWuubuR6t8LdCZyZYebuusFkOrZB
	tXDEHg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqme7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3a74ee77fso5162734a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790627; cv=none;
        d=google.com; s=arc-20260327;
        b=sUz3ZKOdllhu8V2FPdFnqkvNm2zXLitxLq+dhq0CZfiOxJdBNdO1gKh91UuFg51uqf
         w1m8tsX7wgu9DlL02EKinBBvTRcg13mKaT/Ir6yfmqQh9ZCVhawTUDc8Wogh0L65ZfFv
         SwhcaMkWgaMOkSM2N/WxtlIZMq43+dLftrGod6vkSRXPr/FqIDt7y5Nn2V7hC0NBIwhk
         svHtM0+eP3bH6jVZYJjJzdPhHy7VFOU+iLvfAeun4Ygt+rCn6rZ8GnX1n7lM6YUkDPmc
         uowP+nx1SAxvYXAQ7cgEJOFm8xECq2JtAJx30zBuQ32S5Kbg/Mo7u5ZcYBLZl4GmPuNW
         1fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S1GibcSi8ppb2aibwn9jnQWyPdpPCwtJ3CDbi0G70gY=;
        fh=WivGFdGgdFYK4V/FU8Yz55opLG2RNSm6/gqsTQx2Yn8=;
        b=UvjvdxSsqvEripkFBOQrc987PxnL4e2FkZBMqvfqMyzqGDjnYufpVDTncV2QGAgz2y
         FyqD9Duda47dH6mA+2z1tMd0y4tcnVOUwOp77kAaYPlY1Zb00kzeUUfxM9WJGdzYzZL6
         bEbPO7fiaVjwI070VW/VX30+I2gvw0F7TqDgwyzCXvWEKBcJYITXU0ndbZMA4w13gpTm
         hEOdhN8wulqVGdP/kSAbjOQFdVe9qrYvX+MDhNpVwpF6yhstmlBTgdpY+wU0NFmfeiSC
         QBLDaGSHXGXIbS8uEQZkdYJ9lQfXSjwQmU/vRdSeJsP13R9T292ejnS9C73Racm//Obi
         gAQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790627; x=1796395427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1GibcSi8ppb2aibwn9jnQWyPdpPCwtJ3CDbi0G70gY=;
        b=iwFqb3Wks/14zHk6lGmhA6yG4ZqEl7pHwwPtZCTK55plFb/uyttaDCri+gUGekPgt4
         ueEOPyhdBwUeTLNNR3kGHc0aAIj648dDjUCXhNfP/vi5e47ueWG0TDVK8IHbXNgD5rRX
         Ql/nkXmS/quGeWjW4fsv49P1A3ycs4c2DS78p4CgE9sRn4/lu13TIUZWU10IHxlMzTLm
         0GfqOjOj7Hze4+Vqr4AnNWJWGFigsUgO2nDuSNTDOlOcA+kzcgHCr1lieeaLzHVMblK+
         H2iDItm/En+c0Dj26pvD8mEEClqSht/wWFc0/dYhc1cFy/ZK0CblxwZMZwbTAVafSPBh
         sRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790627; x=1796395427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1GibcSi8ppb2aibwn9jnQWyPdpPCwtJ3CDbi0G70gY=;
        b=uY0kPrsfgGMvyBVNAoK4yYDqR9qdP+fXIScay9uBtnhsDfCmgG39vJoU5TToE6sA6T
         inqlDgGazT94sSQfP/xnxo0bCFXAl73CsNItUDvHTi53GGBirklYAzl8yufUAYE1o8jt
         9AvDTjGn371JS1lIDZmfL6gGnWTFqjowru6RZmxA0b6HSCqwop4Fu+uGZ4wqRSUw1ug9
         J9hKEbJvtwstY+5za4tbI8WvSZp15NB3KOISoL0vaHkJWxKZLaZXvwdTT8H46cimsJIH
         5al/6JYV8WyW1FIlxMSh5Saq1OnxErWxdCVuGHmoiqDYC0eyr/VJcCAP05IgqqIXQpe/
         l7Mg==
X-Forwarded-Encrypted: i=1; AL+hErEXVt/cW3ncAd5puJdqguSXsro9ZP50VeBH7p9q0GRUNPm+jcWHmx/mRTxsmOsYxILVxNTMf6T4V+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pV/g7mS2lXfY3ceVk0dBuqZs/UUm8/jlQ9QPE9InSxo0cLgjn
	3YjFR8Y1iMPtsViivwwfvgxYhchJDzEyB/exPfZi2zmORqh7pnRS3KYxT42+wTC5e0Zn2GI/3tt
	pF7i6v1T7PF4SCDdJMxVmyUo71o66FwA+o6gct1WiUTY8ttSYiuHmkG0os2ZcxLDcTj6mg507xS
	boBRDVp8gDmLgf9IvJIsl0tDdIh0x1IWA6G0+STA==
X-Gm-Gg: AZFdTZdcqxAp4eZNM8ENsvUT+NKV00dnAklp7ue+OFNARWjWBgH7NwBZyZjJDyjGDDh
	nUB/+THSkrjvu5BIee0uO6nnjOS3nQW+RqNzuh3NzP1GqfeXvHx2z4kfD2wROXBlOkv25+rZuZR
	EQSSyq0xW0Yn2yaMrEwcaHEL8POJ5vHzP2XU7+yvrK7E7CMQboU9uspz2hEA==
X-Received: by 2002:a17:90b:5303:b0:3b4:41a8:7850 with SMTP id 98e67ed59e1d1-3b441a87c7bmr20310198a91.6.1795790626971;
        Fri, 27 Nov 2026 06:43:46 -0800 (PST)
X-Received: by 2002:a17:90b:5303:b0:3b4:41a8:7850 with SMTP id
 98e67ed59e1d1-3b441a87c7bmr20310177a91.6.1795790626540; Fri, 27 Nov 2026
 06:43:46 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104080705.103689-1-zhuling2709@phytium.com.cn>
In-Reply-To: <20261104080705.103689-1-zhuling2709@phytium.com.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:35 +0100
X-Gm-Features: Aa3M54pZ3frAVHJJ2Jd1_S4cQQq7Xtfe5OZdhfiLiioy0IL2PJC7Snx3dAI1u6w
Message-ID: <CAPx+jO9FhaDrZSvKCQHFsra44_gXBoZ5Z4Zs9ouhRLDYX43QZw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Mark the end of a truncated scatterlist
To: Zhu Ling <zhuling2709@phytium.com.cn>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengjun@phytium.com.cn, wangyinfeng@phytium.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: y-F4Vr9r0FdHuq10oclZy2EDDKl9XoSr
X-Proofpoint-ORIG-GUID: y-F4Vr9r0FdHuq10oclZy2EDDKl9XoSr
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b099723 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=fgrLqfBXAAAA:8 a=Pjbyl_n4pQ3aC6MkrpwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX9gpzdNCv4iu3
 SrEDF5ziLxt88imnqFxbnRW/keQlmhDf+w64Sg0p0FZC97T6fskvjL8nU09Lamr3nUo2VCNJhPg
 cj77eGyBDVxT7U8AqQrSZyrp9m0GM/I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXz4MhUybtbQgk
 kZgKj9rBWKdInZNx/1e45oLRrQpbDvwxrZ3+GoCNgKQRB8CEGNUFtLAnjIVFSlMiSxru5Bixalg
 my0AE8WJO2hXbYz1+GFjWzeqdgg4W3laFH+u2dlluc80JpKQl2g0jVwNeS+D0PJChd06riDDp0E
 Wz2H70aZkbFSgueaK0GKHZPRZGPufVSYUNFtzrQ0+xuy+U1dZHw3q9WnSCzYPaOxtlpQu7UhdrY
 IuRyN35Rk1hrODrXVH1oSWa2NQ4g6SO5mM6fC/6dKNbpZviFJOg8rNRdjr1m9cA6+eHfet4kFlr
 USCRuknF4mxJxWFqure1SiKYlWorkr3ivIGK1/gSmEEoJDaaEBvk9eqYBs9/z+3k3QA1xyJmnPN
 lwsxdeCdUQHdaMl5tKMHAZyaJeQ6SuACORFge8zFyR1w5GGgyD2+gyW6Tc1kAktdfAwQoPXELTa
 ZBDONqwJ518A50Wkt4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 4, 2026 at 9:07=E2=80=AFAM Zhu Ling <zhuling2709@phytium.com.cn=
> wrote:
>
> mmc_blk_data_prep() maps the remaining block request before trimming the
> scatterlist to the size of the current transfer, for example during
> single-block error recovery.
>
> When the transfer needs fewer SG entries, the trimming updates sg_len and
> the length of the final retained entry but leaves SG_END on the original
> last entry. A host calling sg_last(data->sg, data->sg_len) on this list
> will hit its end-marker assertion.
>
> This assertion was reported during read recovery with a Phytium host
> driver in a vendor Linux 6.6 kernel. The same trimming logic is present i=
n
> mainline.
>
> Mark the final retained entry as the end of the scatterlist. Subsequent
> blk_rq_map_sg() calls can still extend the list: blk_next_sg() clears
> premature end markers before advancing to the next entry.
>
> Fixes: 6a79e391df29 ("mmc_block: ensure all sectors that do not have erro=
rs are read")
> Signed-off-by: Zhu Ling <zhuling2709@phytium.com.cn>

I am surprised that this hasn't been reported before, but the patch
looks correct to me. So applied for fixes and by adding a stable tag,
thanks!

Kind regards
Uffe


> ---
> 1. I could not find an MMC-specific statement explicitly permitting an
>    unterminated SG prefix. Feedback from MMC maintainers on this
>    interpretation would be appreciated.
>
> 2. bcm2835_prepare_dma() checks sg_is_last() before dma_map_sg().
>    No failure has been reproduced with that driver.
>
> 3. A userspace metadata reproducer triggers the sg_last() assertion with
>    the original trimming loop. With this change, 120 flat-SG cases and
>    36 chained-SG cases pass, including truncation boundaries and rebuildi=
ng
>    a longer list.
>
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1506,6 +1506,7 @@
>                         data_size -=3D sg->length;
>                         if (data_size <=3D 0) {
>                                 sg->length +=3D data_size;
> +                               sg_mark_end(sg);
>                                 i++;
>                                 break;
>                         }
>
