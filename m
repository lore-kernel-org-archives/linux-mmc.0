Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB3424679
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122164; cv=none; b=ORfHDhJ91a7bsQZfw+urnARkbZC1SP17rtfdgHkET1Dtl6CqrDFzhTOgQHfEizUfQZGQlAhA/bEiIlYfEj6JH+fYq67DmQZJ1opWn/E+iX2qYXRFo106iF5wJy1SfQZbGZBSjQ9TF8SEJCuvc+RikMgfU6U8OHWxBlvZ5ESuns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122164; c=relaxed/simple;
	bh=IzxSwCrhf8d9FMRhv0k7DfYYSIK+phpr001usHYVJgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPCIyDXq7Ht1j7rLtqtBn/EPWAI79XCfdVlXQ1C2SnSyx8I73PR+q8V2yU9jL+iChkSAtU1XfBZfcjIRH16TQ6Vh86hnKfSfiDt/S6bZiFH/T6re91bOeYLLtSbsw1Jzub9B0tDfWcrs0fa4ySy5fA7GHQy5rBwv4brcZWSmJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iNuMl10J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PCBvd+M4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iNuMl10J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCBvd+M4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kcGm3686783
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 10:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDweQGfiDsekOj0T2784PA2rCFWCh+RkBLsA7n7s2rE=; b=iNuMl10JnOkrBvNr
	n2Y5oDnpdHx5rpmFkY4AD9L4wOL2CfWozbGj6GhbcPVGy+3azf9v4cMvSdc4pIq3
	G+MdrFSluFt83raNUpUP0UgtTVrWwCuJYCkSKmR5HHMfJ32Mk5a/8vAq99sgNa24
	OlAjL1QV/kJHxZPM5dI2gO3EMkt48/QnighBWtrYMyabnjUvBmMRCzBPpzw746T/
	q/aZcrQFU7Aym4wZYhN35EC+JO2ecMJLAgFgpUBiMWRU6fhkUoOqBllIpKAW2P0q
	idi9EplvOYdiRzaWbWdDanAPxindBPXXbxi5bBb+ekEoF5vZ/mRjM5Ciy3m7oWz+
	WLnm6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg1au7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 10:22:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93903622880so383516585a.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122161; x=1789726961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDweQGfiDsekOj0T2784PA2rCFWCh+RkBLsA7n7s2rE=;
        b=PCBvd+M4TMViz8z7dzLR1BlUgdhCM3sBSLfwfmB4tebHtwwPeQJmVQfqU+LLdz4fcl
         jx3B+N1OKyyZ0XkQzTRsxsb0oR+JeuxOfuAGhyu/sNvBDrW+DTxioZvKb0cqGvxuK64B
         LsGkzFFYzakEvovtg05OYuKpG00p2ikZnHRTJ+IKyow/IcqnmP8RfTZkU3ALCBgRCaLV
         2SiuGt2oviaYrZ+S0B1gUaODRLoUsZAvxvmRTUa76hTjwAnsItE+oL4OebrU01y4DQww
         wY41xkC2OIGRXadZPhIbfj4cdRQtTW7GP3tdYVeUW2IPt5+4czNbVCdxUrEwR6J3SKtX
         I1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122161; x=1789726961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDweQGfiDsekOj0T2784PA2rCFWCh+RkBLsA7n7s2rE=;
        b=PnsTYDKKHq1ke5cHTKI/MXNsYbQelUzUi7ZsgQ2QfZaknopqHaVzGhc8CaMqpTj6dA
         FSDw9gZUqV0O9LS7nxbOukmpNfEFzh6NBrjnWgKO14qGUGx1Tg6QJOUPqNv3lVYhjmqb
         c8rllxgmPKzr6Y5Jr8dbfR1ECsSTO0fKzwQ7t1F8iRZlbcCy8yZEdxIv8WfQCJ7brI5X
         dmgNrJOhzA85WOK9cCXnP8/PkS2k6V+Bvcca832VtF+vIOJ6nMpfle5+Vcr+LcbcgZcO
         18AQ4e7jlXyv5SvNjkKjaVcf0M/MHN2M/RF75tPt8uvcB+jNgTDnsZQ5QQb7Fs/C1P/J
         NZgQ==
X-Forwarded-Encrypted: i=1; AKwUvByRdixv4h7Ei3J6/a6VnsY7rhoYTe/rYR2wuDkF81whBiRRJDRq6PKBOftQ5qzSdBkjw6ACOcwprsU=@vger.kernel.org
X-Gm-Message-State: AFuF++kXJDvl1azTcV1+Kf1nsUjburxC7NMOc6+elKdDlBvhDp0ebMqS
	wR3+h+ITNAk6ZTdy9NoDr34W5U66p6gdE6QhXXt47yLpTGF9dLWimWsJX8htc/6OjijrnkFByv3
	rHDnOBBMmNZMA1H8Jc9JGiQQpW1Nk5EvzuCoDYI5lJFEWu77bO0L3SLJ0fIO2+m4=
X-Gm-Gg: AYBFou1JsYW2YCWEgvuCky84nOjacoy/At1aOWCggkDQS7bUvzK6bI/XvoGgu1STKd9
	vFhH6+pgafe7uQ1O/FGMIJt5ny/4jinR2twEsfV5d+SAMGhMF1Kj+Colasmx/Mt2OHaWgS3oPAy
	whJ7IRmvZ2ak09eTVLbsr6rRdKEDr8/RyJyGdu0gC+vpVJ1f1sZ+IUHET/VREKBykB67x8EYTTW
	dLs/Vc6iIzCwvXW9oZ/STyK5qsd1Nx1za7v7beM1chYqqaziPpUsZUlDUPpCC20g23uM4TR3rtm
	jCMjIwYVjE34uLryzyFiXY6UtToUyMrGHZbWUEpqSQAsvLzMvIB+NcYQL//brWKdn+sLXTvsdKS
	CAjRTf31uD8kFX1HZNwbKQZI4xEfpdVvqOGJhMyUUbD9q0cuZjlXD60MnRWLlgY4=
X-Received: by 2002:a05:620a:4482:b0:939:c7dc:8712 with SMTP id af79cd13be357-939d7eaef14mr1043308585a.15.1789122161368;
        Fri, 11 Sep 2026 03:22:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:939:c7dc:8712 with SMTP id af79cd13be357-939d7eaef14mr1043304085a.15.1789122160909;
        Fri, 11 Sep 2026 03:22:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60a8a89esm63701295e9.1.2026.09.11.03.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 03:22:39 -0700 (PDT)
Message-ID: <81b9d76d-6036-45fa-8dcc-c180d102ef64@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linusw@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
        Stefan Agner <stefan@agner.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade
 <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Karl Mehltretter <kmehltretter@gmail.com>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        "Jeremy J. Peper" <jeremy@jeremypeper.com>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-6-arnd@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2_jAumBY_D6yaEZH3aQMqrbY8noGLRSC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfXytR2nynu0njX
 +vtuu8CIMyz2pCSBlhbzIckNXV8j1Cg8G1Pi5EwLLEzne7aCJeY2uR2XLisu+HBfPJt7cVjgLFI
 pYA5eWel7I8WskWq7UZkPzcL7ioEF3U=
X-Proofpoint-GUID: 2_jAumBY_D6yaEZH3aQMqrbY8noGLRSC
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa3d672 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=P-IC7800AAAA:8 a=qUSviUioAAAA:8 a=bcVNC_F_AAAA:8 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=_jlGtV7tAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=LCLTMPDaK1Elu1LaZkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22 a=NaVVo_BLbmHoeYVcMpQ9:22
 a=XlnQEC-7T2amSQPCFme7:22 a=nlm17XC03S6CtCLSeiRr:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NSBTYWx0ZWRfX3psh4tEn4TbV
 XtqEPXXly35XEaGtAzpQGZytR4zCjlxbJly9SKCqVXEpsa/UOWiEYHUmsOJ9ovGA+DTya7Z1i5l
 AH4udE1IbkjPY79raoXw5Ai7uE2AjxhmBMjC/59ro9KencDu6UoNToq5SAbCW4fA83fueMKoldk
 WyyS/+OG5WiDpZP7BTcXIOwNthQMWJqgc1+6zJV/Y+OD+buRuk8XA7CU1rY20lwtwkUw7hO9ey8
 mn0nlJ5po0T5BQ8mMridfhsAx1XDH8VzsidnYmJYVWNFuoyMi7mPShAhlj7/kJuWQHQO1KTOMsv
 LSIRL7JPSwe6mqQCVdk4DGzvMarKQ4ZlIv9R4+O47hidwEVK6qqgLKPfiUKfR05m3vDaIqgvYOn
 t9qsI0v9dv0pkrefCER/q/DAyf7vM5Vh6Smlld98/ent0CpOXVDnXG238H5/61Ll/cM/QhXsWx8
 rC3GTCuYFOvLFNChMZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110145

On 9/8/26 17:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'orion' platform is the predecessor to what linux now calls the
> 'mvebu' line of Marvell SoCs, and originally covered orion5x,
> mv78xx0, kirkwood, dove and a few others that do not have any
> upstream support at the moment.
> 
> Only a few board files remain here, these are the ones left
> in 2022 board file purge because they had some level of support
> in Debian or OpenWRT, mostly for commercial NAS or router boxes.
> This distro support is now gone, and nobody has converted the
> board files to devicetree, though the orion5x and dove platforms
> also come with devicetree support for some other machines.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Jeremy J. Peper <jeremy@jeremypeper.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> # thermal
