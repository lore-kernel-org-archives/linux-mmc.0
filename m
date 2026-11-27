Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790640;
	b=ESf2ITcw+NZQp5IA+r6vIky9xH4E7OuVQOGwPDwgnS8CPXH4TZyOyQAfnKXGVlEqoP4U
	 fqWyCzeHb68EnN9mRnzOgxDOmSy9APEerOv8FvotvX0pZ+lV/Uq933JqZGQOxNuORtMf8
	 RAzwIBIgsVMHIkGc5gfplvqeZsuuWOSyrqQvqg/NA2VEcLEFDXElJVjnICVEGULnZjZbb
	 w2cigtCnSnp9IdsdWHNoK6pzIuo25S7j5R/PY+/crq2reW6TEi+Wr5Oim+kKPXcszKABu
	 75ZxkEBMI9AqdZFHfkxqjaj2JUQPix0B1dpkXIEd5LIHAGhYZk8AMLeOn/NMfuzkZmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790640;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Djo26OlJqqISxdmZSNHoEzOkF7q+XbnUuQmHWoc5SVg=;
	b=RLa8TueRQdotv1cvqgt1sCJ1F1ZkNoFVDpkrfmFyy2BylubWg6t6OQV7iuZi+LxEb+7D
	 +XmkBru+OWS4iUh6wrmja9ZZrbDYmsYpAjkknjg9IGfR9f76UyBRKlr2rRDRCK/XUWbRm
	 OXl1a1gKZirN/s3ohcz2durOqbMVoqzxmYUEoTb1WiWm4pgtDvqHzIJ+LsHUYTADMx+yb
	 IYEN2CUYshOJB24DoEbjQ327mq3wXZaUI7tavh1fpaT8+YLq55raMGMrG3pMaokLx5lLJ
	 OiDATCGgrMhhxwTBUgqcKO9zaW8hSwkfq996jaIZRrb6cp0H30fsm0qR571+i0xlvOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f8FSn2iZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yg8aOwut;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE257606A689
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE257606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f8FSn2iZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yg8aOwut
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1aaM2376602
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Djo26OlJqqISxdmZSNHoEzOkF7q+XbnUuQmHWoc5SVg=; b=f8FSn2iZHcsATKgF
	WJAeJexnlKz3j7WLV/2YKbtM3l9JM4zIBSCZNtCVZkSFLnetxhOoCgADsCKPyyDw
	N2AwHYTLToyOhsd07p1V2HSh6hijG5Kri7/5J6frbe0waGRZqJ1DhocyLHtcRJ4U
	hIJBYxdCDzNU2rX8zUiHQusE4nnPYbAfshnlHtQPt4eyyo0/yPHVHSDzvCAUgZko
	ZvEc/0XGqPhrsgO3u4GzHpUFnX7UzoMXhjS4wxNa3gvvFcxJyDr1iQQtB1PKNAhX
	L3acFofw3917cqzAA0cOfLaR825HOzt6Ehe7bT03fkEuPgjCDHb3VLGhIPPb1pqZ
	Vo0VrA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hugjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:43:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f033dc37cfso77365675ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:43:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790638; cv=none;
        d=google.com; s=arc-20260327;
        b=OMkRDjvP/eLfe/fzaXYBhXekcItgwNEBLBYAZS4cFlBJGCD/e2u7tBLCP3vkJi9FHI
         uz3nH/D/A7PElhAcAVm18UFJqzHNpK5eqqgV6jDifp2elUz/kHW5iZLP3Nb5MpyOS/bV
         cWgsJpF05JN+eedPSzk0YccdJ4g6Odk9WNAkzJxaZQz2WTGLI7O570vxsHQrIcrdgic4
         5RlE8w4ZCyS9/31ad6CZuOhCP/isTrbVwNP3WXxmf1ZoTHOaoO8AtLGbGYUn2h+wNbnu
         nQFko8EYzVMR5xcqOw/Mq7nC4Rx3317O9LnFc9agtRIurJVxfxwXV8Kd6RLykyJtenVa
         S1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Djo26OlJqqISxdmZSNHoEzOkF7q+XbnUuQmHWoc5SVg=;
        fh=G8u6/9RBFxBlC23xVWi/02r89EnBunJES98wA/T8nBM=;
        b=OuY87sNRzybksdHIYRP3YxB/AaSsbDqGm4eN4uFNvnQc4y/YAQuoZD5DclXGL7I7dG
         vJcFvnMHXdVQeGr7rZV53NtFrqM/TMm9YaXGGgTPDAJLja3lg2wus+lLZXqBXNAlG9Sr
         fpbN9FtkCQCYRLj2SZDnDc4n/8Jy9V6BLnd+aCY//IBuf11JqM0Ln2lwWRUADkM4aYSF
         FG1A8/EPw5L4uqvWV1w0CSx5TGnGqo4Tf/RAInAWrA4fLI50WnKqQAhs/eEMjadtGrm+
         LOv7fWRSw0lsB7Vkha5pUXauNaV8wY85jtSxZlSQz2+NvdIFjshyn10cLXJsvFZl+sdb
         YxFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790638; x=1796395438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Djo26OlJqqISxdmZSNHoEzOkF7q+XbnUuQmHWoc5SVg=;
        b=Yg8aOwut3eeoZcPoP1WFT57JWYkP4i4Me8Q2XvR+Xe3eOfMdJV3lGgYY5+Dtawlao/
         rO9LFyL5/iusyZTjZVE7/bsDDjS5K9GJI4bpfrcGp9leCoQJOO3Ord/yXUxLtDZkkjD2
         Y/IqVFW9QNi8faxXtt7Yj4r7KKjhjhu7gP8w0H6x5i1SrpMZqtwo9RZ56jJq/v/wyvv9
         LqCb/Q9JJqJ3AizKMagWekdXPQJhXpS788H6KiXndwYyFGbfWnc350DzPw8inniinUGN
         os6pjGznDX+25TQL/9JEmXoghucY4Si4YNUheIJ8dPUERezZ7CXZSy3sk4/npdKM277x
         mkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790638; x=1796395438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Djo26OlJqqISxdmZSNHoEzOkF7q+XbnUuQmHWoc5SVg=;
        b=J2MDtyRSAh2WwcuHrBCtEFsUUI0M3LUtCW+gLjuGu/Vkrvo25aD2/p10urkJHxApbX
         MQatpzumrqdMtZL5jlaRvMnTQdNQhcGy0OXIUF/lAE5pT/cZcv2+Y5mZntOQduj0cVN5
         3Jj680Xm5z6g/NftWdPxSmEkqM6rqjkyYT70+cRUN9X6VPo+gGyGHXW6FEeNQCvq2/8X
         0VnPlfdQsgigSAfusNxOpAqGv2hbLOeheOKp6F+7DlPXbDnKFPpvae5vX3CWqWXvOKnX
         iXTTnjSc5qR8CHJDAWZlhloYvUIPzFWtQ25GO/Sq/k9Gfus1kBTJY/TeOtTkhfA1W0It
         Jruw==
X-Forwarded-Encrypted: i=1; AL+hErHNAi4W+sZMMD0bPJjv0Wczn3SgM+idup9XNxsIpRruCLyEqtJ/Y8dhei7ZxSK1lAP3utEGrrxUkJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QMQwF7Mbl7OuNXcBiofbh5vXZfdzxWfv5sgx46ug6KUUscDe+
	5r9zyY+TrMCcgDwLXL7eFFsCWlsYaUEg8ZNA1BdIkwYbvaZW+lLo/QfcOnY4f0EnUxLvnFAcEZC
	8AmjKqfGAUlAc9k+rFc2tfOMERkxyNOkVlRRvHaCWAsyOeda/45Tct4EDFjiDOJqBbE6fA3yZIx
	X6oQ0nbQAdg0KE/Mnr6fWdUIOCT+y68Kfdh/4/Nw==
X-Gm-Gg: AZFdTZdhEzZjLDjfDk3+tCYtNaOhJ3uzedII+62fZ/nR1plZmE3MpLyyeYRcxvuhQXf
	DD5v+n58zRSfNazS/xjXUeg+18Ie2RUhkU6RnOpwful7+HhJFbhUWt5w6bWUDH/J04xsHfQyaqe
	QbAfYXI8dS1fvM97zwlReICjBt8vYw26LpWCwqw2qIv99EE96veCoKzOmXwQ==
X-Received: by 2002:a17:903:26ce:b0:2ed:3d3b:c5f5 with SMTP id d9443c01a7336-2f0f4a36319mr59480025ad.64.1795790638328;
        Fri, 27 Nov 2026 06:43:58 -0800 (PST)
X-Received: by 2002:a17:903:26ce:b0:2ed:3d3b:c5f5 with SMTP id
 d9443c01a7336-2f0f4a36319mr59479645ad.64.1795790637838; Fri, 27 Nov 2026
 06:43:57 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:43 +0100
X-Gm-Features: Aa3M54qMTgg09-LOlmQZO96BQZ0rleJjZ6ArcEP-EJUj-jeo15UHbVxIpCxwPn0
Message-ID: <CAPx+jO-nDpYJyeKGqjqaO7rMrTW2DzFsv_1WCdFjcR8EborPzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mmc: mmci: stm32: silent data corruption and HS200 fixes
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linusw@kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX1mbGwG+pdWmz
 XQT4ANZqRCag58V2bkUF/8+UgA+uSpAjynl6l6bd3Rjzpw1vPxzxQzhaIJZoBQf9oAhwgQ5DE4G
 yafdt7MyHLAmnX3vYV8XLA+LIz2KX7E=
X-Proofpoint-GUID: 3W7E8Vryj-v5GVaK5eD5jFVG7F_ptfyB
X-Proofpoint-ORIG-GUID: 3W7E8Vryj-v5GVaK5eD5jFVG7F_ptfyB
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b09972f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=uChsZFC9AAAA:8
 a=VTaG3boj7W6_II-ye28A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=ULtXvzFHYWHLyBAuiDia:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXwdGyiUux+ruu
 4jLU/hKNXpECt1R8YhbZwHFTjU6KoJivPraMLTinDzkVEgnxYtPNGPgK4OXiK2hGbnOorvaUGCf
 QGL/MO6YuROnH2CXJ64nEOlZ3eqppKnBNHbzkiKXh9LraK+jOLt0KUo5s7rQA9CRnJa99BnX6TS
 TgUpYde+y7xqUeyJmYAe1sgzs2ZRsQT8RNMeJwl8jSO3yEYYpnt9gYWVUlzvwDFwwdr2cA7fzRC
 IlK+DQk+YfGAjfBeDLs5qF1jAb79Gro9LTxTqwH1oyLw28JknSw5nu+KnjRKZwzc/JLPehtfVhz
 lzrYUStgEyjNuocI5nUtE7bkBkxqNWvOZ0t6kilKolU0MHpiLcIzqfAjlbu3Ic95y5oCagSXTnS
 wILORaAGgBpu7+sLfC+IcaaeHcLWHCZGb7bhnTmRc5oe4p6s7gwIZMbohbKGQu4PrjwYoXOAVzr
 cYRrrLwDf7CeMn+eM6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 4, 2026 at 4:27=E2=80=AFPM Mateusz Nowicki
<mateusz.nowicki@posteo.net> wrote:
>
> The eMMC of the STM32MP257F-DK in HS200 returned stale data and lost
> writes without any error. Patch 1 makes data CRC errors visible to the
> core again. Patches 2 and 3 are the fixes of the ST downstream kernel
> for the causes seen on the DK, as Christophe pointed out. Patches 4 and
> 5 move the eMMC of the DK back to the sdmmc2 pins_a groups and remove
> the pins_b groups I added for it in 7.4: the corruption came from the
> delay block, not from the slew rate, and the slower pins avoid
> overshoots on the SDMMC2 clock. Patches 1-3 are for the mmc tree, 4 and
> 5 for the STM32 device tree, patch 4 needs patch 3.
>
> Tested on the STM32MP257F-DK with a v7.3-rc6 based kernel with the same
> changes, each run writing 832 MiB to the eMMC and reading it back:
>
> - SDMMC2 kernel clock 200 MHz, HS200 at 100 MHz as in mainline: without
>   patch 3 the writes failed with I/O errors in all 9 runs (sdmmc2 pins_a
>   or pins_b, with or without NEGEDGE), with it all 6 runs were correct
>   (pins_a and pins_b).
> - SDMMC2 kernel clock 150 MHz, HS200 at 150 MHz with the delay block:
>   all 6 runs correct (pins_a and pins_b), the tuning picked the same
>   phase in all 10 rebinds on each pin group.
>
> Build tested on v7.4-rc1 (arm64 defconfig, W=3D1). Not tested on
> STM32MP1x.
>
> Changes in v2:
> - Drop "mmc: mmci: stm32: do not use NEGEDGE in HS200 mode". NEGEDGE
>   has no effect with CLKDIV =3D 0 and is valid with a divider, I misread
>   RM0457 (Christophe). The writes at 100 MHz fail because of the delay
>   block, not NEGEDGE.
> - Replace "mmc: mmci: stm32: lock the STM32MP25 delay block again before
>   tuning" with the same change from the ST downstream kernel, "mmc: mmci:
>   stm32: release the delay block before enabling it" (Christophe).
> - Add "mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25
>   SoC" from the ST downstream kernel (Christophe), with dlyb checked
>   before reading min_freq from it.
> - Add "arm64: dts: st: use sdmmc2 pins_a on stm32mp257f-dk" and
>   "arm64: dts: st: remove sdmmc2 pins_b from stm32mp25" (Christophe).
> - Rebase on v7.4-rc1.
> - Link to v1: https://lore.kernel.org/r/20261031120700.42576-1-mateusz.no=
wicki@posteo.net
>
> Christophe Kerello (2):
>   mmc: mmci: stm32: release the delay block before enabling it
>   mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25 SoC
>
> Mateusz Nowicki (3):
>   mmc: mmci: do not count a data CRC error as a complete transfer
>   arm64: dts: st: use sdmmc2 pins_a on stm32mp257f-dk
>   arm64: dts: st: remove sdmmc2 pins_b from stm32mp25
>
>  arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 58 -------------------
>  arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  4 +-
>  drivers/mmc/host/mmci.c                       |  5 +-
>  drivers/mmc/host/mmci_stm32_sdmmc.c           | 28 +++++++--
>  4 files changed, 27 insertions(+), 68 deletions(-)
>
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --
> 2.56.0
>

Patch 1->3 applied for fixes and by adding stable tags, thanks!

Note that, I am planning to submit a pull-request with fixes to Linus
beginning next week. So if things work as expected these should be in
v7.4-rc6, if that can help Alexandre/Maxime to pick up the DTS
changes.

Kind regards
Uffe
