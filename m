Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CC3624DB
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883987; cv=pass; b=TCFDL4HRsxRBOcpVU0V9cKOfM9Q+4bRgdYADVK944JP+sPQzTYJlVDny1HadpDqde59fMPO3lC5v126iteFvAxK9oc8xaqVUf8onBw0U/EdzlXZQuCMtdufnQdpchJr/uXk+YRdxcwYyoOn5WbfTnc4apXNv2OvN9EAh6CiVJhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883987; c=relaxed/simple;
	bh=z6Ik7VoLGVQQhenD4ja6OY6yjon531fHhNys0UUIB3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB64SkBKjp1mhJdvMSkGBmCvg565BiBLIQunb/5bbwPh5p8i42EfBYO3pM4s3howMsJjX+PFBdvTIYEExeOtlio1Zi7gdhr5vdwESHrNVxZMl7VMy/sVFr+GBsW2rJO0/MAr9uBRzoy7szBjF29z6A07rSIiBI0bT2XJwkIHtng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p4albRH/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DaHigSer; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p4albRH/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DaHigSer"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Fe2ZF3614066
	for <linux-mmc@vger.kernel.org>; Tue, 8 Sep 2026 16:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FiVJCIhEJ1S97A0SJMCoNWHRQx+3dU9dPNloTqJCv/E=; b=p4albRH//Qn/IvsE
	XFU7LA/5tUzANLzCfneaxU/jw56gePJecdGRmxnkb54IS9kSu5xCQzabZ5YFgK0M
	94pi5MLU8XoFZwV5jND50+Si9aoF0a9Pc8LJgq8hut+/92yf89UAaHjYemdmr/jg
	GghpKiwqa3ChBzxNylFqI5N7BEEH/UNlwhBheABvJNJsOHr3iIbSMCDgX3/UGs3y
	ENs2y5BZ5NOw/FIsFLltpps7nmRdKiY9wINnzt6OJ6Q7McED2ztmc2lNtqDWyJX7
	AvrqGM4IOSpJEZVFkJ9up3jJ+ovRNQUi9XT0d+h/ZUDIQCKuEj1cblcOQ4FAJwiL
	90VbtQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjaguk2nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 16:12:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc487bd6bfbso1917417a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 09:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883949; cv=none;
        d=google.com; s=arc-20260327;
        b=Tfp+IaxPFO45Nt3qKd67bYPSzmKp/EfK4FeAqpxxZ0UV4bjF4OdowFm0Ed6FVYJhSd
         h0rHrgF6Tk81qE7G18wRLJFU020PfM1rM14+GokjSIGa1mJYSKjTswZm7phitgy2h1D9
         TEvSD3/aRDqKPhu4NHsLcJIKZjEAzjZtuBGwq8kJKX3pFULV9LamN2RW8OdO6jKGUycm
         fJhI5UTYSEFirzMBNbA05KSSYXB9k0pdHeE6MXiCrEs67bNcFhV4HNbM6q7P5sDudMml
         f14LlfgfiJWkxaPpdDCtuhXRD2nqhQsmrdXmZYv52BL+gdV83hKhVRWqtowGo5gwp/6l
         PRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FiVJCIhEJ1S97A0SJMCoNWHRQx+3dU9dPNloTqJCv/E=;
        fh=flrlCsm5JIPaip/ZzVpTUshvDOQY8qyt88P10PPKbJI=;
        b=HMeMqDoE0wT0JEEyx1vlRQRGGqwgOzWZBP+fYKO41zi9owD8uEBKGDP8sBtS0F2zML
         FRTetAdg3DEhRAzUJMWnLxQQqglPeBTQsWS1haNaXk++MYNDtWWEbjJfuXGn/DDnh0KN
         lqpA25vaJv0zFf0+wNMKGxeRfoL7soayNTnK+hywrJGkWD6IZZPCSOcqNiMSDhXhXe/D
         qzZA74MEgcmDpH9B/i9qBopASQT2iy6CdAhIMEz8I9KkH4e1DNnKQXLgQQMlhAEvQWc9
         vlYZwPjTN/oWLjmbvtLc6HT0ykIoWgl2AYAusjmrifs6J1UbkERz59mcztzLu9rDzk32
         W6CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788883949; x=1789488749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FiVJCIhEJ1S97A0SJMCoNWHRQx+3dU9dPNloTqJCv/E=;
        b=DaHigSerFPggCOWwWvnlzffFDOeNS4eJKgYnlqSb0BpSR0rYiCsZAuWEuIsuwjKh53
         PztuH6Y0kdNP+0RrCMbktylIO+S0b0ymc3mIRwTTgDCBqVGGiht9PdURDLtXIl+qKoH8
         TVfc1tbqVoWajK6pQt8/qwBZRRrdf7xYZGdLTPGWfqQ9vIy92RVW9ZIVz9CGgjrIOeZb
         URti8tHIaEOA1iLAgjteyE3BWFsETMIoqtUe+fuGQyukeX6lMmgl8abJUNEhDoWPrMeL
         0Gn2MYv6zllsU6wLfYZQmYrcMFwHBKSVuXY1nh5iasvjJF1Inl8lUBZ5BEup9vZ8PKBd
         IXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883949; x=1789488749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FiVJCIhEJ1S97A0SJMCoNWHRQx+3dU9dPNloTqJCv/E=;
        b=DfgV6f+vtdttK1XiIiBH8BZhvrlCOmKQEZWcNvvSwrAH7urjbhgLX/dstyYDfdXsB8
         njAVF/gavBJ1qQoyFYCZ+n15Um9aaCiACe7DPYIlGnfL4BVvy5LyHgP5ieKqMlHGp7bC
         Ej9iTkZX69NbWZQTudRbNSHVk3xFTXk7R/iWQMmsnxAm/NfQ2AY2MHGh03tY/F1RrPRd
         jbzH1QQXV7nEW5CSLPXzDNeNtvI1/BF32sqgZRc+TKCaAiFX3otR4IJlEWMUBtpgxrLT
         SYjH8vXqK3OwRT0+R0Bm1dufy3Wb++s8qpOK4ljl45uUzSsT6hY4UXncSFARkMD78cKJ
         x7Dg==
X-Forwarded-Encrypted: i=1; AKwUvByCQk6rWII5Pvw0s2PtvV7EKkFv/gACQg7W99fgh1nXsYACaXincNxv+d6H56Y2Bykj2nNajhsbSWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++krcDCiC6ViLPLtkdYCtUvtdqzqqETzFy36t8hmaHhqziG8wukM
	hATUQDy20X5sd3A3m9uZECpq/88k/2UoFZhrFdtTnSGNo0RC9nSbJVcSNfpRG+GCZx2pzYCDQom
	8WXqK2uhsMeZmbqwTwBi0QYgaemRi3Dfb/N42HR6TUAf5kk4+evoAn9gq3x/BhMM2Uapforx2Es
	+cQyPK80n8wdNaoFhQE555GiKL97nOhVX+1OTwzg==
X-Gm-Gg: AYBFou1+HRXtnd75SAr6ZIvllj8/fOZWidP7BC8X2HvvkTMqlE+H+Ont4CNAQgnhogu
	EPVcmdWoxzNFE9eYZjC40xdMeLT/9rzqRfjgO1jeE5yTJEZpAjs0LisNK2dttJ0nsPG241WIdY5
	z71GyAnslFwEjQQuFJwHkcwPs22+x/1vVaplDke+r+NEqI7vb3O8aEI+c9cw==
X-Received: by 2002:a05:6a20:4388:b0:3da:1e2f:3be9 with SMTP id adf61e73a8af0-3da3a0b0070mr48049298637.22.1788883946889;
        Tue, 08 Sep 2026 09:12:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:4388:b0:3da:1e2f:3be9 with SMTP id
 adf61e73a8af0-3da3a0b0070mr48048933637.22.1788883944763; Tue, 08 Sep 2026
 09:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-6-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 18:12:10 +0200
X-Gm-Features: AcwNN1V-QTpVaQn9J1fjgKuNzlErsol8imzgVN_fmVnwtjxrUeG_8rmj_4Iy6Og
Message-ID: <CAPx+jO8BTyauZvXSyWx820Tavb1k0VzwkTwKH_RbpsOZ-C5rmQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linusw@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
        Andreas Kemnade <andreas@kemnade.info>,
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
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6aa033ee cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=qUSviUioAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=P-IC7800AAAA:8 a=bcVNC_F_AAAA:8 a=1XWaLZrsAAAA:8 a=_jlGtV7tAAAA:8
 a=JfrnYn6hAAAA:8 a=M5GUcnROAAAA:8 a=mDV3o1hIAAAA:8 a=wMNdZWldAAAA:8
 a=TWv9rMRwAAAA:8 a=RsYGkj16AAAA:8 a=mK_AVkanAAAA:8 a=bfUIyMDZEVIjfdPaMvAA:9
 a=4kg9chO8BlgyHUCq:21 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=NaVVo_BLbmHoeYVcMpQ9:22 a=d3PnA9EDa4IxuAV0gXij:22 a=XlnQEC-7T2amSQPCFme7:22
 a=nlm17XC03S6CtCLSeiRr:22 a=1CNFftbPRP8L7MoqJWF3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=FUarYpL4UH3yWsho8X8J:22 a=ksoRxi_Xm5RkKWSXGVGi:22 a=TFhhJKGf1URy4M1C39sb:22
 a=3gWm3jAn84ENXaBijsEo:22
X-Proofpoint-GUID: M3IvGdGwUhnkvPOr3cRlYrI2GNhk-T47
X-Proofpoint-ORIG-GUID: M3IvGdGwUhnkvPOr3cRlYrI2GNhk-T47
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3NSBTYWx0ZWRfX6eG2PA9Q593/
 XcLCP0dhb0HCnAhPJZUoVGKgsRziOjerjzQgY84Jzgo9t89K5oAH4zuWSoiuxSks4W0JQj6rTD3
 6aNGWvZnj3AfAds4e5Z2cdp6NvHrZrQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3NSBTYWx0ZWRfXxjsoJ2xYgK+V
 ybzpgFKfnjRmcGDxp+ChSlrn1AVtyKSYv/H32up0cYEYdpCNah1o+YDWy3LkBFlFZ1DrJ17zQK5
 Yv6ezLCIuDLk8/wrVxs6B/wgzUT6bXIT7jTws/r0g7zRR+BPYjcPylJ69+tmy/JpxTpLHVp/clc
 wNooJkLuPzpv17Thc5rqfJBdQ3YjV9RWkgRIqV6wGUfgO98fmFUYFbcTPBoPu0vEo8prL/jGgrE
 pF3tyqFyCenDE7Op7BUIW+CdeG86c0dixrKOcsp9NzHK3AnuswvGXf39tAk4gUUF1pety+K2W1R
 mkTAjlIGa3QlCTl3otWecM0IWbqYMh37Pa31zA2lIwtC/AVJE8WO4r54qHlTCB65UAGB3TSkwcH
 tSml0M9erhSe69xRRja/XYNpzFASflUmfjDHLkH6JmkX2/fhgoRvPa7UAwCYHbmb7uUYoV9aj27
 y5ueGlKpID2dL8S2vWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080175

On Tue, Sep 8, 2026 at 5:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
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
> Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
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

Acked-by: Ulf Hansson <ulfh@kernel.org> # For MMC

Kind regards
Uffe

> ---
>  MAINTAINERS                                   |   2 -
>  arch/arm/Kconfig                              |   2 -
>  arch/arm/Kconfig.debug                        |   2 +-
>  arch/arm/Makefile                             |   2 -
>  arch/arm/configs/dove_defconfig               | 134 ---
>  arch/arm/configs/mv78xx0_defconfig            | 120 ---
>  arch/arm/mach-dove/Kconfig                    |  32 -
>  arch/arm/mach-dove/Makefile                   |   7 -
>  arch/arm/mach-dove/bridge-regs.h              |  50 --
>  arch/arm/mach-dove/cm-a510.c                  |  94 --
>  arch/arm/mach-dove/common.c                   | 449 ----------
>  arch/arm/mach-dove/common.h                   |  46 -
>  arch/arm/mach-dove/dove.h                     | 185 ----
>  arch/arm/mach-dove/irq.c                      |  81 --
>  arch/arm/mach-dove/irqs.h                     |  89 --
>  arch/arm/mach-dove/mpp.c                      | 159 ----
>  arch/arm/mach-dove/mpp.h                      | 197 -----
>  arch/arm/mach-dove/pcie.c                     | 226 -----
>  arch/arm/mach-dove/pm.h                       |  58 --
>  arch/arm/mach-mv78xx0/Kconfig                 |  27 -
>  arch/arm/mach-mv78xx0/Makefile                |   5 -
>  arch/arm/mach-mv78xx0/bridge-regs.h           |  31 -
>  arch/arm/mach-mv78xx0/buffalo-wxl-setup.c     | 183 ----
>  arch/arm/mach-mv78xx0/common.c                | 444 ----------
>  arch/arm/mach-mv78xx0/common.h                |  54 --
>  arch/arm/mach-mv78xx0/irq.c                   |  69 --
>  arch/arm/mach-mv78xx0/irqs.h                  |  87 --
>  arch/arm/mach-mv78xx0/mpp.c                   |  34 -
>  arch/arm/mach-mv78xx0/mpp.h                   | 337 -------
>  arch/arm/mach-mv78xx0/mv78xx0.h               | 134 ---
>  arch/arm/mach-mv78xx0/pcie.c                  | 280 ------
>  arch/arm/mach-orion5x/Kconfig                 |  95 --
>  arch/arm/mach-orion5x/Makefile                |   9 -
>  arch/arm/mach-orion5x/board-dt.c              |   3 +-
>  arch/arm/mach-orion5x/common.c                | 238 +----
>  arch/arm/mach-orion5x/common.h                |  15 -
>  arch/arm/mach-orion5x/dns323-setup.c          | 757 ----------------
>  arch/arm/mach-orion5x/kurobox_pro-setup.c     | 407 ---------
>  arch/arm/mach-orion5x/mv2120-setup.c          | 256 ------
>  arch/arm/mach-orion5x/net2big-setup.c         | 444 ----------
>  arch/arm/mach-orion5x/pci.c                   |   1 -
>  .../arm/mach-orion5x/terastation_pro2-setup.c | 366 --------
>  arch/arm/mach-orion5x/ts209-setup.c           | 331 -------
>  arch/arm/mach-orion5x/ts409-setup.c           | 329 -------
>  arch/arm/mach-orion5x/ts78xx-fpga.h           |  42 -
>  arch/arm/mach-orion5x/ts78xx-setup.c          | 574 ------------
>  arch/arm/mach-orion5x/tsx09-common.c          | 129 ---
>  arch/arm/mach-orion5x/tsx09-common.h          |  21 -
>  arch/arm/mm/Kconfig                           |   2 +-
>  arch/arm/plat-orion/Makefile                  |   2 +-
>  arch/arm/plat-orion/common.c                  | 826 ------------------
>  arch/arm/plat-orion/include/plat/addr-map.h   |  54 --
>  arch/arm/plat-orion/include/plat/common.h     | 104 ---
>  arch/arm/plat-orion/include/plat/time.h       |  20 -
>  arch/arm/plat-orion/pcie.c                    |   1 -
>  arch/arm/plat-orion/time.c                    | 238 -----
>  drivers/ata/Kconfig                           |   3 +-
>  drivers/mmc/host/Kconfig                      |   2 +-
>  drivers/pci/controller/Kconfig                |   2 +-
>  drivers/phy/marvell/Kconfig                   |   2 +-
>  drivers/rtc/Kconfig                           |   2 +-
>  drivers/soc/Makefile                          |   1 -
>  drivers/thermal/Kconfig                       |   2 +-
>  drivers/watchdog/Kconfig                      |   2 +-
>  sound/soc/kirkwood/Kconfig                    |   2 +-
>  65 files changed, 14 insertions(+), 8888 deletions(-)
>  delete mode 100644 arch/arm/configs/dove_defconfig
>  delete mode 100644 arch/arm/configs/mv78xx0_defconfig
>  delete mode 100644 arch/arm/mach-dove/Kconfig
>  delete mode 100644 arch/arm/mach-dove/Makefile
>  delete mode 100644 arch/arm/mach-dove/bridge-regs.h
>  delete mode 100644 arch/arm/mach-dove/cm-a510.c
>  delete mode 100644 arch/arm/mach-dove/common.c
>  delete mode 100644 arch/arm/mach-dove/common.h
>  delete mode 100644 arch/arm/mach-dove/dove.h
>  delete mode 100644 arch/arm/mach-dove/irq.c
>  delete mode 100644 arch/arm/mach-dove/irqs.h
>  delete mode 100644 arch/arm/mach-dove/mpp.c
>  delete mode 100644 arch/arm/mach-dove/mpp.h
>  delete mode 100644 arch/arm/mach-dove/pcie.c
>  delete mode 100644 arch/arm/mach-dove/pm.h
>  delete mode 100644 arch/arm/mach-mv78xx0/Kconfig
>  delete mode 100644 arch/arm/mach-mv78xx0/Makefile
>  delete mode 100644 arch/arm/mach-mv78xx0/bridge-regs.h
>  delete mode 100644 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
>  delete mode 100644 arch/arm/mach-mv78xx0/common.c
>  delete mode 100644 arch/arm/mach-mv78xx0/common.h
>  delete mode 100644 arch/arm/mach-mv78xx0/irq.c
>  delete mode 100644 arch/arm/mach-mv78xx0/irqs.h
>  delete mode 100644 arch/arm/mach-mv78xx0/mpp.c
>  delete mode 100644 arch/arm/mach-mv78xx0/mpp.h
>  delete mode 100644 arch/arm/mach-mv78xx0/mv78xx0.h
>  delete mode 100644 arch/arm/mach-mv78xx0/pcie.c
>  delete mode 100644 arch/arm/mach-orion5x/dns323-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/kurobox_pro-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/mv2120-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/net2big-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/terastation_pro2-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/ts209-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/ts409-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/ts78xx-fpga.h
>  delete mode 100644 arch/arm/mach-orion5x/ts78xx-setup.c
>  delete mode 100644 arch/arm/mach-orion5x/tsx09-common.c
>  delete mode 100644 arch/arm/mach-orion5x/tsx09-common.h
>  delete mode 100644 arch/arm/plat-orion/common.c
>  delete mode 100644 arch/arm/plat-orion/include/plat/addr-map.h
>  delete mode 100644 arch/arm/plat-orion/include/plat/common.h
>  delete mode 100644 arch/arm/plat-orion/include/plat/time.h
>  delete mode 100644 arch/arm/plat-orion/time.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e8fe7640064..028db7ad15ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3080,8 +3080,6 @@ F:        Documentation/devicetree/bindings/arm/mar=
vell/marvell,orion5x.yaml
>  F:     Documentation/devicetree/bindings/soc/dove/
>  F:     arch/arm/boot/dts/marvell/dove*
>  F:     arch/arm/boot/dts/marvell/orion5x*
> -F:     arch/arm/mach-dove/
> -F:     arch/arm/mach-mv78xx0/
>  F:     arch/arm/mach-orion5x/
>  F:     arch/arm/plat-orion/
>  F:     drivers/bus/mvebu-mbus.c
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5770deca136d..da29afce309f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -393,8 +393,6 @@ source "arch/arm/mach-mmp/Kconfig"
>
>  source "arch/arm/mach-mstar/Kconfig"
>
> -source "arch/arm/mach-mv78xx0/Kconfig"
> -
>  source "arch/arm/mach-mvebu/Kconfig"
>
>  source "arch/arm/mach-mxs/Kconfig"
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 56c090840c5a..e2fc89055463 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -583,7 +583,7 @@ choice
>
>         config DEBUG_MVEBU_UART0_ALTERNATE
>                 bool "Kernel low-level debugging messages via MVEBU UART0=
 (new bootloaders)"
> -               depends on ARCH_MVEBU || ARCH_DOVE || ARCH_MV78XX0 || ARC=
H_ORION5X
> +               depends on ARCH_MVEBU || ARCH_ORION5X
>                 select DEBUG_UART_8250
>                 help
>                   Say Y here if you want kernel low-level debugging suppo=
rt
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index f5bc9ad7f6f5..5421a3ec3825 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -179,7 +179,6 @@ machine-$(CONFIG_ARCH_BERLIN)               +=3D berl=
in
>  machine-$(CONFIG_ARCH_CLPS711X)                +=3D clps711x
>  machine-$(CONFIG_ARCH_DAVINCI)         +=3D davinci
>  machine-$(CONFIG_ARCH_DIGICOLOR)       +=3D digicolor
> -machine-$(CONFIG_ARCH_DOVE)            +=3D dove
>  machine-$(CONFIG_ARCH_EXYNOS)          +=3D exynos
>  machine-$(CONFIG_ARCH_GEMINI)          +=3D gemini
>  machine-$(CONFIG_ARCH_HIGHBANK)                +=3D highbank
> @@ -190,7 +189,6 @@ machine-$(CONFIG_ARCH_LPC18XX)              +=3D lpc1=
8xx
>  machine-$(CONFIG_ARCH_LPC32XX)         +=3D lpc32xx
>  machine-$(CONFIG_ARCH_MESON)           +=3D meson
>  machine-$(CONFIG_ARCH_MMP)             +=3D mmp
> -machine-$(CONFIG_ARCH_MV78XX0)         +=3D mv78xx0
>  machine-$(CONFIG_ARCH_MVEBU)           +=3D mvebu
>  machine-$(CONFIG_ARCH_MXC)             +=3D imx
>  machine-$(CONFIG_ARCH_MEDIATEK)                +=3D mediatek
> diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defc=
onfig
> deleted file mode 100644
> index 917a864fec74..000000000000
> --- a/arch/arm/configs/dove_defconfig
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -CONFIG_SYSVIPC=3Dy
> -CONFIG_NO_HZ_IDLE=3Dy
> -CONFIG_HIGH_RES_TIMERS=3Dy
> -CONFIG_LOG_BUF_SHIFT=3D14
> -CONFIG_EXPERT=3Dy
> -# CONFIG_ARCH_MULTI_V6 is not set
> -CONFIG_ARCH_MULTI_V7=3Dy
> -CONFIG_ARCH_DOVE=3Dy
> -CONFIG_MACH_CM_A510=3Dy
> -CONFIG_HIGHMEM=3Dy
> -CONFIG_ATAGS=3Dy
> -CONFIG_ARM_APPENDED_DTB=3Dy
> -CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> -CONFIG_VFP=3Dy
> -CONFIG_MODULES=3Dy
> -CONFIG_MODULE_UNLOAD=3Dy
> -CONFIG_PARTITION_ADVANCED=3Dy
> -CONFIG_NET=3Dy
> -CONFIG_PACKET=3Dy
> -CONFIG_UNIX=3Dy
> -CONFIG_INET=3Dy
> -CONFIG_IP_MULTICAST=3Dy
> -CONFIG_IP_PNP=3Dy
> -CONFIG_IP_PNP_DHCP=3Dy
> -CONFIG_IP_PNP_BOOTP=3Dy
> -# CONFIG_IPV6 is not set
> -CONFIG_PCI=3Dy
> -CONFIG_PCI_MSI=3Dy
> -CONFIG_PCI_MVEBU=3Dy
> -CONFIG_DEVTMPFS=3Dy
> -CONFIG_DEVTMPFS_MOUNT=3Dy
> -CONFIG_MTD=3Dy
> -CONFIG_MTD_CMDLINE_PARTS=3Dy
> -CONFIG_MTD_BLOCK=3Dy
> -CONFIG_MTD_CFI=3Dy
> -CONFIG_MTD_JEDECPROBE=3Dy
> -CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
> -CONFIG_MTD_CFI_GEOMETRY=3Dy
> -# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
> -CONFIG_MTD_CFI_INTELEXT=3Dy
> -CONFIG_MTD_CFI_STAA=3Dy
> -CONFIG_MTD_PHYSMAP=3Dy
> -CONFIG_MTD_M25P80=3Dy
> -CONFIG_MTD_SPI_NOR=3Dy
> -CONFIG_BLK_DEV_LOOP=3Dy
> -CONFIG_BLK_DEV_RAM=3Dy
> -CONFIG_BLK_DEV_RAM_COUNT=3D1
> -# CONFIG_SCSI_PROC_FS is not set
> -CONFIG_BLK_DEV_SD=3Dy
> -# CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_SCSI_LOWLEVEL is not set
> -CONFIG_ATA=3Dy
> -CONFIG_SATA_MV=3Dy
> -CONFIG_NETDEVICES=3Dy
> -CONFIG_MV643XX_ETH=3Dy
> -# CONFIG_INPUT_MOUSEDEV is not set
> -CONFIG_INPUT_EVDEV=3Dy
> -# CONFIG_KEYBOARD_ATKBD is not set
> -# CONFIG_MOUSE_PS2 is not set
> -# CONFIG_SERIO is not set
> -CONFIG_LEGACY_PTY_COUNT=3D16
> -CONFIG_SERIAL_8250=3Dy
> -CONFIG_SERIAL_8250_CONSOLE=3Dy
> -CONFIG_SERIAL_8250_RUNTIME_UARTS=3D2
> -CONFIG_SERIAL_OF_PLATFORM=3Dy
> -# CONFIG_HW_RANDOM is not set
> -CONFIG_I2C=3Dy
> -CONFIG_I2C_CHARDEV=3Dy
> -CONFIG_I2C_MV64XXX=3Dy
> -CONFIG_SPI=3Dy
> -CONFIG_SPI_ORION=3Dy
> -# CONFIG_HWMON is not set
> -CONFIG_THERMAL=3Dy
> -CONFIG_DOVE_THERMAL=3Dy
> -CONFIG_WATCHDOG=3Dy
> -CONFIG_ORION_WATCHDOG=3Dy
> -CONFIG_USB=3Dy
> -CONFIG_USB_XHCI_HCD=3Dy
> -CONFIG_USB_EHCI_HCD=3Dy
> -CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> -CONFIG_USB_STORAGE=3Dy
> -CONFIG_MMC=3Dy
> -CONFIG_MMC_SDHCI=3Dy
> -CONFIG_MMC_SDHCI_PLTFM=3Dy
> -CONFIG_MMC_SDHCI_DOVE=3Dy
> -CONFIG_NEW_LEDS=3Dy
> -CONFIG_LEDS_CLASS=3Dy
> -CONFIG_LEDS_GPIO=3Dy
> -CONFIG_LEDS_TRIGGERS=3Dy
> -CONFIG_LEDS_TRIGGER_TIMER=3Dy
> -CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> -CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
> -CONFIG_RTC_CLASS=3Dy
> -CONFIG_RTC_DRV_MV=3Dy
> -CONFIG_DMADEVICES=3Dy
> -CONFIG_MV_XOR=3Dy
> -CONFIG_EXT2_FS=3Dy
> -CONFIG_EXT4_FS=3Dy
> -# CONFIG_EXT4_FS_XATTR is not set
> -CONFIG_ISO9660_FS=3Dy
> -CONFIG_JOLIET=3Dy
> -CONFIG_UDF_FS=3Dm
> -CONFIG_MSDOS_FS=3Dy
> -CONFIG_VFAT_FS=3Dy
> -CONFIG_TMPFS=3Dy
> -CONFIG_JFFS2_FS=3Dy
> -CONFIG_NFS_FS=3Dy
> -CONFIG_ROOT_NFS=3Dy
> -CONFIG_NLS_CODEPAGE_437=3Dy
> -CONFIG_NLS_CODEPAGE_850=3Dy
> -CONFIG_NLS_ISO8859_1=3Dy
> -CONFIG_NLS_ISO8859_2=3Dy
> -CONFIG_NLS_UTF8=3Dy
> -CONFIG_TIMER_STATS=3Dy
> -CONFIG_CRYPTO_NULL=3Dy
> -CONFIG_CRYPTO_BLOWFISH=3Dy
> -CONFIG_CRYPTO_TEA=3Dy
> -CONFIG_CRYPTO_TWOFISH=3Dy
> -CONFIG_CRYPTO_ECB=3Dm
> -CONFIG_CRYPTO_HMAC=3Dy
> -CONFIG_CRYPTO_MD4=3Dy
> -CONFIG_CRYPTO_SHA1=3Dy
> -CONFIG_CRYPTO_SHA256=3Dy
> -CONFIG_CRYPTO_SHA512=3Dy
> -CONFIG_CRYPTO_DEFLATE=3Dy
> -CONFIG_CRYPTO_LZO=3Dy
> -CONFIG_CRYPTO_DEV_MARVELL_CESA=3Dy
> -CONFIG_PRINTK_TIME=3Dy
> -# CONFIG_DEBUG_BUGVERBOSE is not set
> -CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> -CONFIG_MAGIC_SYSRQ=3Dy
> -CONFIG_DEBUG_FS=3Dy
> -# CONFIG_SCHED_DEBUG is not set
> -CONFIG_DEBUG_USER=3Dy
> diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx=
0_defconfig
> deleted file mode 100644
> index e3cc8de7c1c2..000000000000
> --- a/arch/arm/configs/mv78xx0_defconfig
> +++ /dev/null
> @@ -1,120 +0,0 @@
> -CONFIG_SYSVIPC=3Dy
> -CONFIG_NO_HZ_IDLE=3Dy
> -CONFIG_HIGH_RES_TIMERS=3Dy
> -CONFIG_PREEMPT=3Dy
> -CONFIG_LOG_BUF_SHIFT=3D14
> -CONFIG_EXPERT=3Dy
> -CONFIG_KALLSYMS_ALL=3Dy
> -CONFIG_PROFILING=3Dy
> -CONFIG_ARCH_MULTI_V5=3Dy
> -# CONFIG_ARCH_MULTI_V6 is not set
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_MV78XX0=3Dy
> -CONFIG_MACH_TERASTATION_WXL=3Dy
> -CONFIG_HIGHMEM=3Dy
> -CONFIG_ATAGS=3Dy
> -CONFIG_VFP=3Dy
> -CONFIG_KPROBES=3Dy
> -CONFIG_MODULES=3Dy
> -CONFIG_MODULE_UNLOAD=3Dy
> -CONFIG_PARTITION_ADVANCED=3Dy
> -CONFIG_BSD_DISKLABEL=3Dy
> -CONFIG_NET=3Dy
> -CONFIG_PACKET=3Dy
> -CONFIG_UNIX=3Dy
> -CONFIG_INET=3Dy
> -CONFIG_IP_MULTICAST=3Dy
> -CONFIG_IP_PNP=3Dy
> -CONFIG_IP_PNP_DHCP=3Dy
> -CONFIG_IP_PNP_BOOTP=3Dy
> -# CONFIG_IPV6 is not set
> -CONFIG_NET_PKTGEN=3Dm
> -CONFIG_MTD=3Dy
> -CONFIG_MTD_CMDLINE_PARTS=3Dy
> -CONFIG_MTD_BLOCK=3Dy
> -CONFIG_MTD_CFI=3Dy
> -CONFIG_MTD_JEDECPROBE=3Dy
> -CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
> -CONFIG_MTD_CFI_GEOMETRY=3Dy
> -CONFIG_MTD_CFI_INTELEXT=3Dy
> -CONFIG_MTD_CFI_AMDSTD=3Dy
> -CONFIG_MTD_PHYSMAP=3Dy
> -CONFIG_MTD_RAW_NAND=3Dy
> -CONFIG_MTD_NAND_ORION=3Dy
> -CONFIG_BLK_DEV_LOOP=3Dy
> -# CONFIG_SCSI_PROC_FS is not set
> -CONFIG_BLK_DEV_SD=3Dy
> -CONFIG_BLK_DEV_SR=3Dm
> -CONFIG_CHR_DEV_SG=3Dm
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_ATA=3Dy
> -CONFIG_SATA_MV=3Dy
> -CONFIG_NETDEVICES=3Dy
> -CONFIG_MII=3Dy
> -CONFIG_NET_PCI=3Dy
> -CONFIG_MV643XX_ETH=3Dy
> -# CONFIG_INPUT_MOUSEDEV is not set
> -CONFIG_MARVELL_PHY=3Dy
> -CONFIG_INPUT_EVDEV=3Dy
> -# CONFIG_INPUT_KEYBOARD is not set
> -# CONFIG_INPUT_MOUSE is not set
> -# CONFIG_SERIO is not set
> -# CONFIG_VT is not set
> -CONFIG_LEGACY_PTY_COUNT=3D16
> -CONFIG_SERIAL_8250=3Dy
> -CONFIG_SERIAL_8250_CONSOLE=3Dy
> -# CONFIG_SERIAL_8250_PCI is not set
> -CONFIG_SERIAL_8250_RUNTIME_UARTS=3D2
> -# CONFIG_HW_RANDOM is not set
> -CONFIG_I2C=3Dy
> -CONFIG_I2C_CHARDEV=3Dy
> -CONFIG_I2C_MV64XXX=3Dy
> -CONFIG_USB=3Dy
> -CONFIG_USB_EHCI_HCD=3Dy
> -CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> -CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> -CONFIG_USB_PRINTER=3Dy
> -CONFIG_USB_STORAGE=3Dy
> -CONFIG_USB_STORAGE_DATAFAB=3Dy
> -CONFIG_USB_STORAGE_FREECOM=3Dy
> -CONFIG_USB_STORAGE_SDDR09=3Dy
> -CONFIG_USB_STORAGE_SDDR55=3Dy
> -CONFIG_USB_STORAGE_JUMPSHOT=3Dy
> -CONFIG_NEW_LEDS=3Dy
> -CONFIG_LEDS_CLASS=3Dy
> -CONFIG_LEDS_TRIGGERS=3Dy
> -CONFIG_LEDS_TRIGGER_TIMER=3Dy
> -CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> -CONFIG_RTC_CLASS=3Dy
> -CONFIG_RTC_DRV_DS1307=3Dy
> -CONFIG_RTC_DRV_RS5C372=3Dy
> -CONFIG_RTC_DRV_M41T80=3Dy
> -CONFIG_EXT2_FS=3Dy
> -CONFIG_EXT4_FS=3Dy
> -# CONFIG_EXT4_FS_XATTR is not set
> -CONFIG_ISO9660_FS=3Dm
> -CONFIG_JOLIET=3Dy
> -CONFIG_UDF_FS=3Dm
> -CONFIG_MSDOS_FS=3Dy
> -CONFIG_VFAT_FS=3Dy
> -CONFIG_TMPFS=3Dy
> -CONFIG_JFFS2_FS=3Dy
> -CONFIG_CRAMFS=3Dy
> -CONFIG_NFS_FS=3Dy
> -CONFIG_NFS_V3=3Dy
> -CONFIG_ROOT_NFS=3Dy
> -CONFIG_NLS_CODEPAGE_437=3Dy
> -CONFIG_NLS_CODEPAGE_850=3Dy
> -CONFIG_NLS_ISO8859_1=3Dy
> -CONFIG_NLS_ISO8859_2=3Dy
> -CONFIG_CRYPTO_CBC=3Dm
> -CONFIG_CRYPTO_ECB=3Dm
> -# CONFIG_DEBUG_BUGVERBOSE is not set
> -CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> -CONFIG_MAGIC_SYSRQ=3Dy
> -CONFIG_DEBUG_FS=3Dy
> -CONFIG_DEBUG_KERNEL=3Dy
> -# CONFIG_SLUB_DEBUG is not set
> -CONFIG_SCHEDSTATS=3Dy
> -CONFIG_DEBUG_USER=3Dy
> -CONFIG_DEBUG_LL=3Dy
> diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
> deleted file mode 100644
> index f547120e223e..000000000000
> --- a/arch/arm/mach-dove/Kconfig
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -menuconfig ARCH_DOVE
> -       bool "Marvell Dove (DEPRECATED)" if ARCH_MULTI_V7
> -       depends on ATAGS
> -       select CPU_PJ4
> -       select GPIOLIB
> -       select MVEBU_MBUS
> -       select PINCTRL
> -       select PINCTRL_DOVE
> -       select PLAT_ORION_LEGACY
> -       select PM_GENERIC_DOMAINS if PM
> -       select PCI_QUIRKS if PCI
> -       help
> -         Support for the Marvell Dove SoC 88AP510 using board files.
> -
> -         Support for this machine will be removed in early 2027, unless
> -         there is a strong reason to keep it. Users should migrate to
> -         the devicetree-enabled version (CONFIG_MACH_DOVE) instead.
> -
> -if ARCH_DOVE
> -
> -config DOVE_LEGACY
> -       bool
> -
> -config MACH_CM_A510
> -       bool "CompuLab CM-A510 Board"
> -       select DOVE_LEGACY
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         CompuLab CM-A510 Board.
> -
> -endif
> diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
> deleted file mode 100644
> index 0d31390be069..000000000000
> --- a/arch/arm/mach-dove/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D -I$(srctree)/arch/arm/plat-orion/include
> -
> -obj-y                          +=3D common.o
> -obj-$(CONFIG_DOVE_LEGACY)      +=3D irq.o mpp.o
> -obj-$(CONFIG_PCI)              +=3D pcie.o
> -obj-$(CONFIG_MACH_CM_A510)     +=3D cm-a510.o
> diff --git a/arch/arm/mach-dove/bridge-regs.h b/arch/arm/mach-dove/bridge=
-regs.h
> deleted file mode 100644
> index 6fbc152d0950..000000000000
> --- a/arch/arm/mach-dove/bridge-regs.h
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/* Mbus-L to Mbus Bridge Registers */
> -
> -#ifndef __ASM_ARCH_BRIDGE_REGS_H
> -#define __ASM_ARCH_BRIDGE_REGS_H
> -
> -#include "dove.h"
> -
> -#define CPU_CONFIG             (BRIDGE_VIRT_BASE + 0x0000)
> -
> -#define CPU_CONTROL            (BRIDGE_VIRT_BASE + 0x0104)
> -#define  CPU_CTRL_PCIE0_LINK   0x00000001
> -#define  CPU_RESET             0x00000002
> -#define  CPU_CTRL_PCIE1_LINK   0x00000008
> -
> -#define RSTOUTn_MASK           (BRIDGE_VIRT_BASE + 0x0108)
> -#define RSTOUTn_MASK_PHYS      (BRIDGE_PHYS_BASE + 0x0108)
> -#define  SOFT_RESET_OUT_EN     0x00000004
> -
> -#define SYSTEM_SOFT_RESET      (BRIDGE_VIRT_BASE + 0x010c)
> -#define  SOFT_RESET            0x00000001
> -
> -#define BRIDGE_CAUSE           (BRIDGE_VIRT_BASE + 0x0110)
> -#define  BRIDGE_INT_TIMER1_CLR (~0x0004)
> -
> -#define IRQ_VIRT_BASE          (BRIDGE_VIRT_BASE + 0x0200)
> -#define IRQ_CAUSE_LOW_OFF      0x0000
> -#define IRQ_MASK_LOW_OFF       0x0004
> -#define FIQ_MASK_LOW_OFF       0x0008
> -#define ENDPOINT_MASK_LOW_OFF  0x000c
> -#define IRQ_CAUSE_HIGH_OFF     0x0010
> -#define IRQ_MASK_HIGH_OFF      0x0014
> -#define FIQ_MASK_HIGH_OFF      0x0018
> -#define ENDPOINT_MASK_HIGH_OFF 0x001c
> -#define PCIE_INTERRUPT_MASK_OFF        0x0020
> -
> -#define IRQ_MASK_LOW           (IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF)
> -#define FIQ_MASK_LOW           (IRQ_VIRT_BASE + FIQ_MASK_LOW_OFF)
> -#define ENDPOINT_MASK_LOW      (IRQ_VIRT_BASE + ENDPOINT_MASK_LOW_OFF)
> -#define IRQ_MASK_HIGH          (IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF)
> -#define FIQ_MASK_HIGH          (IRQ_VIRT_BASE + FIQ_MASK_HIGH_OFF)
> -#define ENDPOINT_MASK_HIGH     (IRQ_VIRT_BASE + ENDPOINT_MASK_HIGH_OFF)
> -#define PCIE_INTERRUPT_MASK    (IRQ_VIRT_BASE + PCIE_INTERRUPT_MASK_OFF)
> -
> -#define POWER_MANAGEMENT       (BRIDGE_VIRT_BASE + 0x011c)
> -
> -#define TIMER_VIRT_BASE                (BRIDGE_VIRT_BASE + 0x0300)
> -#define TIMER_PHYS_BASE         (BRIDGE_PHYS_BASE + 0x0300)
> -
> -#endif
> diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
> deleted file mode 100644
> index beb532537c22..000000000000
> --- a/arch/arm/mach-dove/cm-a510.c
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-dove/cm-a510.c
> - *
> - * Copyright (C) 2010 CompuLab, Ltd.
> - * Konstantin Sinyuk <kostyas@compulab.co.il>
> - *
> - * Based on Marvell DB-MV88AP510-BP Development Board Setup
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/ata_platform.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/spi/spi.h>
> -#include <linux/spi/flash.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -
> -#include "dove.h"
> -#include "common.h"
> -
> -static struct mv643xx_eth_platform_data cm_a510_ge00_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR_DEFAULT,
> -};
> -
> -static struct mv_sata_platform_data cm_a510_sata_data =3D {
> -       .n_ports        =3D 1,
> -};
> -
> -/*
> - * SPI Devices:
> - * SPI0: 1M Flash Winbond w25q32bv
> - */
> -static const struct flash_platform_data cm_a510_spi_flash_data =3D {
> -       .type           =3D "w25q32bv",
> -};
> -
> -static struct spi_board_info __initdata cm_a510_spi_flash_info[] =3D {
> -       {
> -               .modalias       =3D "m25p80",
> -               .platform_data  =3D &cm_a510_spi_flash_data,
> -               .irq            =3D -1,
> -               .max_speed_hz   =3D 20000000,
> -               .bus_num        =3D 0,
> -               .chip_select    =3D 0,
> -       },
> -};
> -
> -static int __init cm_a510_pci_init(void)
> -{
> -       if (machine_is_cm_a510())
> -               dove_pcie_init(1, 1);
> -
> -       return 0;
> -}
> -
> -subsys_initcall(cm_a510_pci_init);
> -
> -/* Board Init */
> -static void __init cm_a510_init(void)
> -{
> -       /*
> -        * Basic Dove setup. Needs to be called early.
> -        */
> -       dove_init();
> -
> -       dove_ge00_init(&cm_a510_ge00_data);
> -       dove_ehci0_init();
> -       dove_ehci1_init();
> -       dove_sata_init(&cm_a510_sata_data);
> -       dove_sdio0_init();
> -       dove_sdio1_init();
> -       dove_spi0_init();
> -       dove_spi1_init();
> -       dove_uart0_init();
> -       dove_uart1_init();
> -       dove_i2c_init();
> -       spi_register_board_info(cm_a510_spi_flash_info,
> -                               ARRAY_SIZE(cm_a510_spi_flash_info));
> -}
> -
> -MACHINE_START(CM_A510, "Compulab CM-A510 Board")
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D DOVE_NR_IRQS,
> -       .init_machine   =3D cm_a510_init,
> -       .map_io         =3D dove_map_io,
> -       .init_early     =3D dove_init_early,
> -       .init_irq       =3D dove_init_irq,
> -       .init_time      =3D dove_timer_init,
> -       .restart        =3D dove_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> deleted file mode 100644
> index 35e978514591..000000000000
> --- a/arch/arm/mach-dove/common.c
> +++ /dev/null
> @@ -1,449 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-dove/common.c
> - *
> - * Core functions for Marvell Dove 88AP510 System On Chip
> - */
> -
> -#include <linux/clk-provider.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/platform_data/dma-mv_xor.h>
> -#include <linux/platform_data/usb-ehci-orion.h>
> -#include <linux/platform_device.h>
> -#include <linux/soc/dove/pmu.h>
> -#include <asm/hardware/cache-tauros2.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/map.h>
> -#include <asm/mach/time.h>
> -#include <plat/common.h>
> -#include <plat/irq.h>
> -#include <plat/time.h>
> -#include "bridge-regs.h"
> -#include "pm.h"
> -#include "common.h"
> -
> -/* These can go away once Dove uses the mvebu-mbus DT binding */
> -#define DOVE_MBUS_PCIE0_MEM_TARGET    0x4
> -#define DOVE_MBUS_PCIE0_MEM_ATTR      0xe8
> -#define DOVE_MBUS_PCIE0_IO_TARGET     0x4
> -#define DOVE_MBUS_PCIE0_IO_ATTR       0xe0
> -#define DOVE_MBUS_PCIE1_MEM_TARGET    0x8
> -#define DOVE_MBUS_PCIE1_MEM_ATTR      0xe8
> -#define DOVE_MBUS_PCIE1_IO_TARGET     0x8
> -#define DOVE_MBUS_PCIE1_IO_ATTR       0xe0
> -#define DOVE_MBUS_CESA_TARGET         0x3
> -#define DOVE_MBUS_CESA_ATTR           0x1
> -#define DOVE_MBUS_BOOTROM_TARGET      0x1
> -#define DOVE_MBUS_BOOTROM_ATTR        0xfd
> -#define DOVE_MBUS_SCRATCHPAD_TARGET   0xd
> -#define DOVE_MBUS_SCRATCHPAD_ATTR     0x0
> -
> -/***********************************************************************=
******
> - * I/O Address Mapping
> - ***********************************************************************=
*****/
> -static struct map_desc __maybe_unused dove_io_desc[] __initdata =3D {
> -       {
> -               .virtual        =3D (unsigned long) DOVE_SB_REGS_VIRT_BAS=
E,
> -               .pfn            =3D __phys_to_pfn(DOVE_SB_REGS_PHYS_BASE)=
,
> -               .length         =3D DOVE_SB_REGS_SIZE,
> -               .type           =3D MT_DEVICE,
> -       }, {
> -               .virtual        =3D (unsigned long) DOVE_NB_REGS_VIRT_BAS=
E,
> -               .pfn            =3D __phys_to_pfn(DOVE_NB_REGS_PHYS_BASE)=
,
> -               .length         =3D DOVE_NB_REGS_SIZE,
> -               .type           =3D MT_DEVICE,
> -       },
> -};
> -
> -void __init dove_map_io(void)
> -{
> -       iotable_init(dove_io_desc, ARRAY_SIZE(dove_io_desc));
> -}
> -
> -/***********************************************************************=
******
> - * CLK tree
> - ***********************************************************************=
*****/
> -static int dove_tclk;
> -
> -static DEFINE_SPINLOCK(gating_lock);
> -static struct clk *tclk;
> -
> -static struct clk __init *dove_register_gate(const char *name,
> -                                            const char *parent, u8 bit_i=
dx)
> -{
> -       return clk_register_gate(NULL, name, parent, 0,
> -                                (void __iomem *)CLOCK_GATING_CONTROL,
> -                                bit_idx, 0, &gating_lock);
> -}
> -
> -static void __init dove_clk_init(void)
> -{
> -       struct clk *usb0, *usb1, *sata, *pex0, *pex1, *sdio0, *sdio1;
> -       struct clk *nand, *camera, *i2s0, *i2s1, *crypto, *ac97, *pdma;
> -       struct clk *xor0, *xor1, *ge;
> -
> -       tclk =3D clk_register_fixed_rate(NULL, "tclk", NULL, 0, dove_tclk=
);
> -
> -       usb0 =3D dove_register_gate("usb0", "tclk", CLOCK_GATING_BIT_USB0=
);
> -       usb1 =3D dove_register_gate("usb1", "tclk", CLOCK_GATING_BIT_USB1=
);
> -       sata =3D dove_register_gate("sata", "tclk", CLOCK_GATING_BIT_SATA=
);
> -       pex0 =3D dove_register_gate("pex0", "tclk", CLOCK_GATING_BIT_PCIE=
0);
> -       pex1 =3D dove_register_gate("pex1", "tclk", CLOCK_GATING_BIT_PCIE=
1);
> -       sdio0 =3D dove_register_gate("sdio0", "tclk", CLOCK_GATING_BIT_SD=
IO0);
> -       sdio1 =3D dove_register_gate("sdio1", "tclk", CLOCK_GATING_BIT_SD=
IO1);
> -       nand =3D dove_register_gate("nand", "tclk", CLOCK_GATING_BIT_NAND=
);
> -       camera =3D dove_register_gate("camera", "tclk", CLOCK_GATING_BIT_=
CAMERA);
> -       i2s0 =3D dove_register_gate("i2s0", "tclk", CLOCK_GATING_BIT_I2S0=
);
> -       i2s1 =3D dove_register_gate("i2s1", "tclk", CLOCK_GATING_BIT_I2S1=
);
> -       crypto =3D dove_register_gate("crypto", "tclk", CLOCK_GATING_BIT_=
CRYPTO);
> -       ac97 =3D dove_register_gate("ac97", "tclk", CLOCK_GATING_BIT_AC97=
);
> -       pdma =3D dove_register_gate("pdma", "tclk", CLOCK_GATING_BIT_PDMA=
);
> -       xor0 =3D dove_register_gate("xor0", "tclk", CLOCK_GATING_BIT_XOR0=
);
> -       xor1 =3D dove_register_gate("xor1", "tclk", CLOCK_GATING_BIT_XOR1=
);
> -       dove_register_gate("gephy", "tclk", CLOCK_GATING_BIT_GIGA_PHY);
> -       ge =3D dove_register_gate("ge", "gephy", CLOCK_GATING_BIT_GBE);
> -
> -       orion_clkdev_add(NULL, "orion_spi.0", tclk);
> -       orion_clkdev_add(NULL, "orion_spi.1", tclk);
> -       orion_clkdev_add(NULL, "orion_wdt", tclk);
> -       orion_clkdev_add(NULL, "mv64xxx_i2c.0", tclk);
> -
> -       orion_clkdev_add(NULL, "orion-ehci.0", usb0);
> -       orion_clkdev_add(NULL, "orion-ehci.1", usb1);
> -       orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);
> -       orion_clkdev_add(NULL, "sata_mv.0", sata);
> -       orion_clkdev_add("0", "pcie", pex0);
> -       orion_clkdev_add("1", "pcie", pex1);
> -       orion_clkdev_add(NULL, "sdhci-dove.0", sdio0);
> -       orion_clkdev_add(NULL, "sdhci-dove.1", sdio1);
> -       orion_clkdev_add(NULL, "orion_nand", nand);
> -       orion_clkdev_add(NULL, "cafe1000-ccic.0", camera);
> -       orion_clkdev_add(NULL, "mvebu-audio.0", i2s0);
> -       orion_clkdev_add(NULL, "mvebu-audio.1", i2s1);
> -       orion_clkdev_add(NULL, "mv_crypto", crypto);
> -       orion_clkdev_add(NULL, "dove-ac97", ac97);
> -       orion_clkdev_add(NULL, "dove-pdma", pdma);
> -       orion_clkdev_add(NULL, MV_XOR_NAME ".0", xor0);
> -       orion_clkdev_add(NULL, MV_XOR_NAME ".1", xor1);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI0
> - ***********************************************************************=
*****/
> -void __init dove_ehci0_init(void)
> -{
> -       orion_ehci_init(DOVE_USB0_PHYS_BASE, IRQ_DOVE_USB0, EHCI_PHY_NA);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI1
> - ***********************************************************************=
*****/
> -void __init dove_ehci1_init(void)
> -{
> -       orion_ehci_1_init(DOVE_USB1_PHYS_BASE, IRQ_DOVE_USB1);
> -}
> -
> -/***********************************************************************=
******
> - * GE00
> - ***********************************************************************=
*****/
> -void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
> -{
> -       orion_ge00_init(eth_data, DOVE_GE00_PHYS_BASE,
> -                       IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR,
> -                       1600);
> -}
> -
> -/***********************************************************************=
******
> - * SoC RTC
> - ***********************************************************************=
*****/
> -static void __init dove_rtc_init(void)
> -{
> -       orion_rtc_init(DOVE_RTC_PHYS_BASE, IRQ_DOVE_RTC);
> -}
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -void __init dove_sata_init(struct mv_sata_platform_data *sata_data)
> -{
> -       orion_sata_init(sata_data, DOVE_SATA_PHYS_BASE, IRQ_DOVE_SATA);
> -
> -}
> -
> -/***********************************************************************=
******
> - * UART0
> - ***********************************************************************=
*****/
> -void __init dove_uart0_init(void)
> -{
> -       orion_uart0_init(DOVE_UART0_VIRT_BASE, DOVE_UART0_PHYS_BASE,
> -                        IRQ_DOVE_UART_0, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * UART1
> - ***********************************************************************=
*****/
> -void __init dove_uart1_init(void)
> -{
> -       orion_uart1_init(DOVE_UART1_VIRT_BASE, DOVE_UART1_PHYS_BASE,
> -                        IRQ_DOVE_UART_1, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * UART2
> - ***********************************************************************=
*****/
> -void __init dove_uart2_init(void)
> -{
> -       orion_uart2_init(DOVE_UART2_VIRT_BASE, DOVE_UART2_PHYS_BASE,
> -                        IRQ_DOVE_UART_2, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * UART3
> - ***********************************************************************=
*****/
> -void __init dove_uart3_init(void)
> -{
> -       orion_uart3_init(DOVE_UART3_VIRT_BASE, DOVE_UART3_PHYS_BASE,
> -                        IRQ_DOVE_UART_3, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * SPI
> - ***********************************************************************=
*****/
> -void __init dove_spi0_init(void)
> -{
> -       orion_spi_init(DOVE_SPI0_PHYS_BASE);
> -}
> -
> -void __init dove_spi1_init(void)
> -{
> -       orion_spi_1_init(DOVE_SPI1_PHYS_BASE);
> -}
> -
> -/***********************************************************************=
******
> - * I2C
> - ***********************************************************************=
*****/
> -void __init dove_i2c_init(void)
> -{
> -       orion_i2c_init(DOVE_I2C_PHYS_BASE, IRQ_DOVE_I2C, 10);
> -}
> -
> -/***********************************************************************=
******
> - * Time handling
> - ***********************************************************************=
*****/
> -void __init dove_init_early(void)
> -{
> -       orion_time_set_base(TIMER_VIRT_BASE);
> -       mvebu_mbus_init("marvell,dove-mbus",
> -                       BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
> -                       DOVE_MC_WINS_BASE, DOVE_MC_WINS_SZ);
> -}
> -
> -static int __init dove_find_tclk(void)
> -{
> -       return 166666667;
> -}
> -
> -void __init dove_timer_init(void)
> -{
> -       dove_tclk =3D dove_find_tclk();
> -       orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
> -                       IRQ_DOVE_BRIDGE, dove_tclk);
> -}
> -
> -/***********************************************************************=
******
> - * XOR 0
> - ***********************************************************************=
*****/
> -static void __init dove_xor0_init(void)
> -{
> -       orion_xor0_init(DOVE_XOR0_PHYS_BASE, DOVE_XOR0_HIGH_PHYS_BASE,
> -                       IRQ_DOVE_XOR_00, IRQ_DOVE_XOR_01);
> -}
> -
> -/***********************************************************************=
******
> - * XOR 1
> - ***********************************************************************=
*****/
> -static void __init dove_xor1_init(void)
> -{
> -       orion_xor1_init(DOVE_XOR1_PHYS_BASE, DOVE_XOR1_HIGH_PHYS_BASE,
> -                       IRQ_DOVE_XOR_10, IRQ_DOVE_XOR_11);
> -}
> -
> -/***********************************************************************=
******
> - * SDIO
> - ***********************************************************************=
*****/
> -static u64 sdio_dmamask =3D DMA_BIT_MASK(32);
> -
> -static struct resource dove_sdio0_resources[] =3D {
> -       {
> -               .start  =3D DOVE_SDIO0_PHYS_BASE,
> -               .end    =3D DOVE_SDIO0_PHYS_BASE + 0xff,
> -               .flags  =3D IORESOURCE_MEM,
> -       }, {
> -               .start  =3D IRQ_DOVE_SDIO0,
> -               .end    =3D IRQ_DOVE_SDIO0,
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct platform_device dove_sdio0 =3D {
> -       .name           =3D "sdhci-dove",
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .dma_mask               =3D &sdio_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -       .resource       =3D dove_sdio0_resources,
> -       .num_resources  =3D ARRAY_SIZE(dove_sdio0_resources),
> -};
> -
> -void __init dove_sdio0_init(void)
> -{
> -       platform_device_register(&dove_sdio0);
> -}
> -
> -static struct resource dove_sdio1_resources[] =3D {
> -       {
> -               .start  =3D DOVE_SDIO1_PHYS_BASE,
> -               .end    =3D DOVE_SDIO1_PHYS_BASE + 0xff,
> -               .flags  =3D IORESOURCE_MEM,
> -       }, {
> -               .start  =3D IRQ_DOVE_SDIO1,
> -               .end    =3D IRQ_DOVE_SDIO1,
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct platform_device dove_sdio1 =3D {
> -       .name           =3D "sdhci-dove",
> -       .id             =3D 1,
> -       .dev            =3D {
> -               .dma_mask               =3D &sdio_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -       .resource       =3D dove_sdio1_resources,
> -       .num_resources  =3D ARRAY_SIZE(dove_sdio1_resources),
> -};
> -
> -void __init dove_sdio1_init(void)
> -{
> -       platform_device_register(&dove_sdio1);
> -}
> -
> -void __init dove_setup_cpu_wins(void)
> -{
> -       /*
> -        * The PCIe windows will no longer be statically allocated
> -        * here once Dove is migrated to the pci-mvebu driver. The
> -        * non-PCIe windows will no longer be created here once Dove
> -        * fully moves to DT.
> -        */
> -       mvebu_mbus_add_window_remap_by_id(DOVE_MBUS_PCIE0_IO_TARGET,
> -                                         DOVE_MBUS_PCIE0_IO_ATTR,
> -                                         DOVE_PCIE0_IO_PHYS_BASE,
> -                                         DOVE_PCIE0_IO_SIZE,
> -                                         DOVE_PCIE0_IO_BUS_BASE);
> -       mvebu_mbus_add_window_remap_by_id(DOVE_MBUS_PCIE1_IO_TARGET,
> -                                         DOVE_MBUS_PCIE1_IO_ATTR,
> -                                         DOVE_PCIE1_IO_PHYS_BASE,
> -                                         DOVE_PCIE1_IO_SIZE,
> -                                         DOVE_PCIE1_IO_BUS_BASE);
> -       mvebu_mbus_add_window_by_id(DOVE_MBUS_PCIE0_MEM_TARGET,
> -                                   DOVE_MBUS_PCIE0_MEM_ATTR,
> -                                   DOVE_PCIE0_MEM_PHYS_BASE,
> -                                   DOVE_PCIE0_MEM_SIZE);
> -       mvebu_mbus_add_window_by_id(DOVE_MBUS_PCIE1_MEM_TARGET,
> -                                   DOVE_MBUS_PCIE1_MEM_ATTR,
> -                                   DOVE_PCIE1_MEM_PHYS_BASE,
> -                                   DOVE_PCIE1_MEM_SIZE);
> -       mvebu_mbus_add_window_by_id(DOVE_MBUS_CESA_TARGET,
> -                                   DOVE_MBUS_CESA_ATTR,
> -                                   DOVE_CESA_PHYS_BASE,
> -                                   DOVE_CESA_SIZE);
> -       mvebu_mbus_add_window_by_id(DOVE_MBUS_BOOTROM_TARGET,
> -                                   DOVE_MBUS_BOOTROM_ATTR,
> -                                   DOVE_BOOTROM_PHYS_BASE,
> -                                   DOVE_BOOTROM_SIZE);
> -       mvebu_mbus_add_window_by_id(DOVE_MBUS_SCRATCHPAD_TARGET,
> -                                   DOVE_MBUS_SCRATCHPAD_ATTR,
> -                                   DOVE_SCRATCHPAD_PHYS_BASE,
> -                                   DOVE_SCRATCHPAD_SIZE);
> -}
> -
> -static struct resource orion_wdt_resource[] =3D {
> -               DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
> -               DEFINE_RES_MEM(RSTOUTn_MASK_PHYS, 0x04),
> -};
> -
> -static struct platform_device orion_wdt_device =3D {
> -       .name           =3D "orion_wdt",
> -       .id             =3D -1,
> -       .num_resources  =3D ARRAY_SIZE(orion_wdt_resource),
> -       .resource       =3D orion_wdt_resource,
> -};
> -
> -static void __init __maybe_unused orion_wdt_init(void)
> -{
> -       platform_device_register(&orion_wdt_device);
> -}
> -
> -static const struct dove_pmu_domain_initdata pmu_domains[] __initconst =
=3D {
> -       {
> -               .pwr_mask =3D PMU_PWR_VPU_PWR_DWN_MASK,
> -               .rst_mask =3D PMU_SW_RST_VIDEO_MASK,
> -               .iso_mask =3D PMU_ISO_VIDEO_MASK,
> -               .name =3D "vpu-domain",
> -       }, {
> -               .pwr_mask =3D PMU_PWR_GPU_PWR_DWN_MASK,
> -               .rst_mask =3D PMU_SW_RST_GPU_MASK,
> -               .iso_mask =3D PMU_ISO_GPU_MASK,
> -               .name =3D "gpu-domain",
> -       }, {
> -               /* sentinel */
> -       },
> -};
> -
> -static const struct dove_pmu_initdata pmu_data __initconst =3D {
> -       .pmc_base =3D DOVE_PMU_VIRT_BASE,
> -       .pmu_base =3D DOVE_PMU_VIRT_BASE + 0x8000,
> -       .irq =3D IRQ_DOVE_PMU,
> -       .irq_domain_start =3D IRQ_DOVE_PMU_START,
> -       .domains =3D pmu_domains,
> -};
> -
> -void __init dove_init(void)
> -{
> -       pr_info("Dove 88AP510 SoC, TCLK =3D %d MHz.\n",
> -               (dove_tclk + 499999) / 1000000);
> -
> -#ifdef CONFIG_CACHE_TAUROS2
> -       tauros2_init(0);
> -#endif
> -       dove_setup_cpu_wins();
> -
> -       /* Setup root of clk tree */
> -       dove_clk_init();
> -
> -       /* internal devices that every board has */
> -       dove_init_pmu_legacy(&pmu_data);
> -       dove_rtc_init();
> -       dove_xor0_init();
> -       dove_xor1_init();
> -}
> -
> -void dove_restart(enum reboot_mode mode, const char *cmd)
> -{
> -       /*
> -        * Enable soft reset to assert RSTOUTn.
> -        */
> -       writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
> -
> -       /*
> -        * Assert soft reset.
> -        */
> -       writel(SOFT_RESET, SYSTEM_SOFT_RESET);
> -
> -       while (1)
> -               ;
> -}
> diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
> deleted file mode 100644
> index 57ebc413d68c..000000000000
> --- a/arch/arm/mach-dove/common.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * arch/arm/mach-dove/common.h
> - *
> - * Core functions for Marvell Dove 88AP510 System On Chip
> - */
> -
> -#ifndef __ARCH_DOVE_COMMON_H
> -#define __ARCH_DOVE_COMMON_H
> -
> -#include <linux/reboot.h>
> -
> -struct mv643xx_eth_platform_data;
> -struct mv_sata_platform_data;
> -
> -extern void dove_timer_init(void);
> -
> -/*
> - * Basic Dove init functions used early by machine-setup.
> - */
> -void dove_map_io(void);
> -void dove_init(void);
> -void dove_init_early(void);
> -void dove_init_irq(void);
> -void dove_setup_cpu_wins(void);
> -void dove_ge00_init(struct mv643xx_eth_platform_data *eth_data);
> -void dove_sata_init(struct mv_sata_platform_data *sata_data);
> -#ifdef CONFIG_PCI
> -void dove_pcie_init(int init_port0, int init_port1);
> -#else
> -static inline void dove_pcie_init(int init_port0, int init_port1) { }
> -#endif
> -void dove_ehci0_init(void);
> -void dove_ehci1_init(void);
> -void dove_uart0_init(void);
> -void dove_uart1_init(void);
> -void dove_uart2_init(void);
> -void dove_uart3_init(void);
> -void dove_spi0_init(void);
> -void dove_spi1_init(void);
> -void dove_i2c_init(void);
> -void dove_sdio0_init(void);
> -void dove_sdio1_init(void);
> -void dove_restart(enum reboot_mode, const char *);
> -
> -#endif
> diff --git a/arch/arm/mach-dove/dove.h b/arch/arm/mach-dove/dove.h
> deleted file mode 100644
> index e5054e3b0b78..000000000000
> --- a/arch/arm/mach-dove/dove.h
> +++ /dev/null
> @@ -1,185 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/* Generic definitions for Marvell Dove 88AP510 SoC */
> -
> -#ifndef __ASM_ARCH_DOVE_H
> -#define __ASM_ARCH_DOVE_H
> -
> -#include "irqs.h"
> -
> -/*
> - * Marvell Dove address maps.
> - *
> - * phys                virt            size
> - * c8000000    fdb00000        1M      Cryptographic SRAM
> - * e0000000    @runtime        128M    PCIe-0 Memory space
> - * e8000000    @runtime        128M    PCIe-1 Memory space
> - * f1000000    fec00000        1M      on-chip south-bridge registers
> - * f1800000    fe400000        8M      on-chip north-bridge registers
> - * f2000000    fee00000        1M      PCIe-0 I/O space
> - * f2100000    fef00000        1M      PCIe-1 I/O space
> - */
> -
> -#define DOVE_CESA_PHYS_BASE            0xc8000000
> -#define DOVE_CESA_VIRT_BASE            IOMEM(0xfdb00000)
> -#define DOVE_CESA_SIZE                 SZ_1M
> -
> -#define DOVE_PCIE0_MEM_PHYS_BASE       0xe0000000
> -#define DOVE_PCIE0_MEM_SIZE            SZ_128M
> -
> -#define DOVE_PCIE1_MEM_PHYS_BASE       0xe8000000
> -#define DOVE_PCIE1_MEM_SIZE            SZ_128M
> -
> -#define DOVE_BOOTROM_PHYS_BASE         0xf8000000
> -#define DOVE_BOOTROM_SIZE              SZ_128M
> -
> -#define DOVE_SCRATCHPAD_PHYS_BASE      0xf0000000
> -#define DOVE_SCRATCHPAD_VIRT_BASE      IOMEM(0xfdd00000)
> -#define DOVE_SCRATCHPAD_SIZE           SZ_1M
> -
> -#define DOVE_SB_REGS_PHYS_BASE         0xf1000000
> -#define DOVE_SB_REGS_VIRT_BASE         IOMEM(0xfec00000)
> -#define DOVE_SB_REGS_SIZE              SZ_1M
> -
> -#define DOVE_NB_REGS_PHYS_BASE         0xf1800000
> -#define DOVE_NB_REGS_VIRT_BASE         IOMEM(0xfe400000)
> -#define DOVE_NB_REGS_SIZE              SZ_8M
> -
> -#define DOVE_PCIE0_IO_PHYS_BASE                0xf2000000
> -#define DOVE_PCIE0_IO_BUS_BASE         0x00000000
> -#define DOVE_PCIE0_IO_SIZE             SZ_64K
> -
> -#define DOVE_PCIE1_IO_PHYS_BASE                0xf2100000
> -#define DOVE_PCIE1_IO_BUS_BASE         0x00010000
> -#define DOVE_PCIE1_IO_SIZE             SZ_64K
> -
> -/*
> - * Dove Core Registers Map
> - */
> -
> -/* SPI, I2C, UART */
> -#define DOVE_I2C_PHYS_BASE     (DOVE_SB_REGS_PHYS_BASE + 0x11000)
> -#define DOVE_UART0_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x12000)
> -#define DOVE_UART0_VIRT_BASE   (DOVE_SB_REGS_VIRT_BASE + 0x12000)
> -#define DOVE_UART1_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x12100)
> -#define DOVE_UART1_VIRT_BASE   (DOVE_SB_REGS_VIRT_BASE + 0x12100)
> -#define DOVE_UART2_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x12200)
> -#define DOVE_UART2_VIRT_BASE   (DOVE_SB_REGS_VIRT_BASE + 0x12200)
> -#define DOVE_UART3_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x12300)
> -#define DOVE_UART3_VIRT_BASE   (DOVE_SB_REGS_VIRT_BASE + 0x12300)
> -#define DOVE_SPI0_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x10600)
> -#define DOVE_SPI1_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x14600)
> -
> -/* North-South Bridge */
> -#define BRIDGE_VIRT_BASE       (DOVE_SB_REGS_VIRT_BASE + 0x20000)
> -#define BRIDGE_PHYS_BASE       (DOVE_SB_REGS_PHYS_BASE + 0x20000)
> -#define  BRIDGE_WINS_BASE       (BRIDGE_PHYS_BASE)
> -#define  BRIDGE_WINS_SZ         (0x80)
> -
> -/* Cryptographic Engine */
> -#define DOVE_CRYPT_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x30000)
> -
> -/* PCIe 0 */
> -#define DOVE_PCIE0_VIRT_BASE   (DOVE_SB_REGS_VIRT_BASE + 0x40000)
> -
> -/* USB */
> -#define DOVE_USB0_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x50000)
> -#define DOVE_USB1_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x51000)
> -
> -/* XOR 0 Engine */
> -#define DOVE_XOR0_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x60800)
> -#define DOVE_XOR0_VIRT_BASE    (DOVE_SB_REGS_VIRT_BASE + 0x60800)
> -#define DOVE_XOR0_HIGH_PHYS_BASE       (DOVE_SB_REGS_PHYS_BASE + 0x60A00=
)
> -#define DOVE_XOR0_HIGH_VIRT_BASE       (DOVE_SB_REGS_VIRT_BASE + 0x60A00=
)
> -
> -/* XOR 1 Engine */
> -#define DOVE_XOR1_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x60900)
> -#define DOVE_XOR1_VIRT_BASE    (DOVE_SB_REGS_VIRT_BASE + 0x60900)
> -#define DOVE_XOR1_HIGH_PHYS_BASE       (DOVE_SB_REGS_PHYS_BASE + 0x60B00=
)
> -#define DOVE_XOR1_HIGH_VIRT_BASE       (DOVE_SB_REGS_VIRT_BASE + 0x60B00=
)
> -
> -/* Gigabit Ethernet */
> -#define DOVE_GE00_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0x70000)
> -
> -/* PCIe 1 */
> -#define DOVE_PCIE1_VIRT_BASE   (DOVE_SB_REGS_VIRT_BASE + 0x80000)
> -
> -/* CAFE */
> -#define DOVE_SDIO0_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x92000)
> -#define DOVE_SDIO1_PHYS_BASE   (DOVE_SB_REGS_PHYS_BASE + 0x90000)
> -#define DOVE_CAM_PHYS_BASE     (DOVE_SB_REGS_PHYS_BASE + 0x94000)
> -#define DOVE_CAFE_WIN_PHYS_BASE        (DOVE_SB_REGS_PHYS_BASE + 0x98000=
)
> -
> -/* SATA */
> -#define DOVE_SATA_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0xa0000)
> -
> -/* I2S/SPDIF */
> -#define DOVE_AUD0_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0xb0000)
> -#define DOVE_AUD1_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0xb4000)
> -
> -/* NAND Flash Controller */
> -#define DOVE_NFC_PHYS_BASE     (DOVE_SB_REGS_PHYS_BASE + 0xc0000)
> -
> -/* MPP, GPIO, Reset Sampling */
> -#define DOVE_MPP_VIRT_BASE     (DOVE_SB_REGS_VIRT_BASE + 0xd0200)
> -#define DOVE_PMU_MPP_GENERAL_CTRL (DOVE_MPP_VIRT_BASE + 0x10)
> -#define DOVE_RESET_SAMPLE_LO   (DOVE_MPP_VIRT_BASE + 0x014)
> -#define DOVE_RESET_SAMPLE_HI   (DOVE_MPP_VIRT_BASE + 0x018)
> -#define DOVE_GPIO_LO_VIRT_BASE (DOVE_SB_REGS_VIRT_BASE + 0xd0400)
> -#define DOVE_GPIO_HI_VIRT_BASE (DOVE_SB_REGS_VIRT_BASE + 0xd0420)
> -#define DOVE_GPIO2_VIRT_BASE    (DOVE_SB_REGS_VIRT_BASE + 0xe8400)
> -#define DOVE_MPP_GENERAL_VIRT_BASE     (DOVE_SB_REGS_VIRT_BASE + 0xe803c=
)
> -#define  DOVE_AU1_SPDIFO_GPIO_EN       (1 << 1)
> -#define  DOVE_NAND_GPIO_EN             (1 << 0)
> -#define DOVE_MPP_CTRL4_VIRT_BASE       (DOVE_GPIO_LO_VIRT_BASE + 0x40)
> -#define  DOVE_SPI_GPIO_SEL             (1 << 5)
> -#define  DOVE_UART1_GPIO_SEL           (1 << 4)
> -#define  DOVE_AU1_GPIO_SEL             (1 << 3)
> -#define  DOVE_CAM_GPIO_SEL             (1 << 2)
> -#define  DOVE_SD1_GPIO_SEL             (1 << 1)
> -#define  DOVE_SD0_GPIO_SEL             (1 << 0)
> -
> -/* Power Management */
> -#define DOVE_PMU_VIRT_BASE     (DOVE_SB_REGS_VIRT_BASE + 0xd0000)
> -#define DOVE_PMU_SIG_CTRL      (DOVE_PMU_VIRT_BASE + 0x802c)
> -
> -/* Real Time Clock */
> -#define DOVE_RTC_PHYS_BASE     (DOVE_SB_REGS_PHYS_BASE + 0xd8500)
> -
> -/* AC97 */
> -#define DOVE_AC97_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0xe0000)
> -#define DOVE_AC97_VIRT_BASE    (DOVE_SB_REGS_VIRT_BASE + 0xe0000)
> -
> -/* Peripheral DMA */
> -#define DOVE_PDMA_PHYS_BASE    (DOVE_SB_REGS_PHYS_BASE + 0xe4000)
> -#define DOVE_PDMA_VIRT_BASE    (DOVE_SB_REGS_VIRT_BASE + 0xe4000)
> -
> -#define DOVE_GLOBAL_CONFIG_1   (DOVE_SB_REGS_VIRT_BASE + 0xe802C)
> -#define  DOVE_TWSI_ENABLE_OPTION1      (1 << 7)
> -#define DOVE_GLOBAL_CONFIG_2   (DOVE_SB_REGS_VIRT_BASE + 0xe8030)
> -#define  DOVE_TWSI_ENABLE_OPTION2      (1 << 20)
> -#define  DOVE_TWSI_ENABLE_OPTION3      (1 << 21)
> -#define  DOVE_TWSI_OPTION3_GPIO                (1 << 22)
> -#define DOVE_SSP_PHYS_BASE     (DOVE_SB_REGS_PHYS_BASE + 0xec000)
> -#define DOVE_SSP_CTRL_STATUS_1 (DOVE_SB_REGS_VIRT_BASE + 0xe8034)
> -#define  DOVE_SSP_ON_AU1               (1 << 0)
> -#define  DOVE_SSP_CLOCK_ENABLE         (1 << 1)
> -#define  DOVE_SSP_BPB_CLOCK_SRC_SSP    (1 << 11)
> -/* Memory Controller */
> -#define DOVE_MC_PHYS_BASE       (DOVE_NB_REGS_PHYS_BASE + 0x00000)
> -#define  DOVE_MC_WINS_BASE      (DOVE_MC_PHYS_BASE + 0x100)
> -#define  DOVE_MC_WINS_SZ        (0x8)
> -#define DOVE_MC_VIRT_BASE      (DOVE_NB_REGS_VIRT_BASE + 0x00000)
> -
> -/* LCD Controller */
> -#define DOVE_LCD_PHYS_BASE     (DOVE_NB_REGS_PHYS_BASE + 0x10000)
> -#define DOVE_LCD1_PHYS_BASE    (DOVE_NB_REGS_PHYS_BASE + 0x20000)
> -#define DOVE_LCD2_PHYS_BASE    (DOVE_NB_REGS_PHYS_BASE + 0x10000)
> -#define DOVE_LCD_DCON_PHYS_BASE        (DOVE_NB_REGS_PHYS_BASE + 0x30000=
)
> -
> -/* Graphic Engine */
> -#define DOVE_GPU_PHYS_BASE     (DOVE_NB_REGS_PHYS_BASE + 0x40000)
> -
> -/* Video Engine */
> -#define DOVE_VPU_PHYS_BASE     (DOVE_NB_REGS_PHYS_BASE + 0x400000)
> -
> -#endif
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> deleted file mode 100644
> index 027a8f87bc2e..000000000000
> --- a/arch/arm/mach-dove/irq.c
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-dove/irq.c
> - *
> - * Dove IRQ handling.
> - */
> -#include <linux/init.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -#include <asm/exception.h>
> -
> -#include <plat/irq.h>
> -#include <plat/orion-gpio.h>
> -
> -#include "pm.h"
> -#include "bridge-regs.h"
> -#include "common.h"
> -
> -static int __initdata gpio0_irqs[4] =3D {
> -       IRQ_DOVE_GPIO_0_7,
> -       IRQ_DOVE_GPIO_8_15,
> -       IRQ_DOVE_GPIO_16_23,
> -       IRQ_DOVE_GPIO_24_31,
> -};
> -
> -static int __initdata gpio1_irqs[4] =3D {
> -       IRQ_DOVE_HIGH_GPIO,
> -       0,
> -       0,
> -       0,
> -};
> -
> -static int __initdata gpio2_irqs[4] =3D {
> -       0,
> -       0,
> -       0,
> -       0,
> -};
> -
> -static void __iomem *dove_irq_base =3D IRQ_VIRT_BASE;
> -
> -static asmlinkage void
> -__exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
> -{
> -       u32 stat;
> -
> -       stat =3D readl_relaxed(dove_irq_base + IRQ_CAUSE_LOW_OFF);
> -       stat &=3D readl_relaxed(dove_irq_base + IRQ_MASK_LOW_OFF);
> -       if (stat) {
> -               unsigned int hwirq =3D 1 + __fls(stat);
> -               handle_IRQ(hwirq, regs);
> -               return;
> -       }
> -       stat =3D readl_relaxed(dove_irq_base + IRQ_CAUSE_HIGH_OFF);
> -       stat &=3D readl_relaxed(dove_irq_base + IRQ_MASK_HIGH_OFF);
> -       if (stat) {
> -               unsigned int hwirq =3D 33 + __fls(stat);
> -               handle_IRQ(hwirq, regs);
> -               return;
> -       }
> -}
> -
> -void __init dove_init_irq(void)
> -{
> -       orion_irq_init(1, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
> -       orion_irq_init(33, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
> -
> -       set_handle_irq(dove_legacy_handle_irq);
> -
> -       /*
> -        * Initialize gpiolib for GPIOs 0-71.
> -        */
> -       orion_gpio_init(0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
> -                       IRQ_DOVE_GPIO_START, gpio0_irqs);
> -
> -       orion_gpio_init(32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
> -                       IRQ_DOVE_GPIO_START + 32, gpio1_irqs);
> -
> -       orion_gpio_init(64, 8, DOVE_GPIO2_VIRT_BASE, 0,
> -                       IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
> -}
> diff --git a/arch/arm/mach-dove/irqs.h b/arch/arm/mach-dove/irqs.h
> deleted file mode 100644
> index 5467098c7042..000000000000
> --- a/arch/arm/mach-dove/irqs.h
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/* IRQ definitions for Marvell Dove 88AP510 SoC */
> -
> -#ifndef __ASM_ARCH_IRQS_H
> -#define __ASM_ARCH_IRQS_H
> -
> -/*
> - * Dove Low Interrupt Controller
> - */
> -#define IRQ_DOVE_BRIDGE                (1 + 0)
> -#define IRQ_DOVE_H2C           (1 + 1)
> -#define IRQ_DOVE_C2H           (1 + 2)
> -#define IRQ_DOVE_NAND          (1 + 3)
> -#define IRQ_DOVE_PDMA          (1 + 4)
> -#define IRQ_DOVE_SPI1          (1 + 5)
> -#define IRQ_DOVE_SPI0          (1 + 6)
> -#define IRQ_DOVE_UART_0                (1 + 7)
> -#define IRQ_DOVE_UART_1                (1 + 8)
> -#define IRQ_DOVE_UART_2                (1 + 9)
> -#define IRQ_DOVE_UART_3                (1 + 10)
> -#define IRQ_DOVE_I2C           (1 + 11)
> -#define IRQ_DOVE_GPIO_0_7      (1 + 12)
> -#define IRQ_DOVE_GPIO_8_15     (1 + 13)
> -#define IRQ_DOVE_GPIO_16_23    (1 + 14)
> -#define IRQ_DOVE_PCIE0_ERR     (1 + 15)
> -#define IRQ_DOVE_PCIE0         (1 + 16)
> -#define IRQ_DOVE_PCIE1_ERR     (1 + 17)
> -#define IRQ_DOVE_PCIE1         (1 + 18)
> -#define IRQ_DOVE_I2S0          (1 + 19)
> -#define IRQ_DOVE_I2S0_ERR      (1 + 20)
> -#define IRQ_DOVE_I2S1          (1 + 21)
> -#define IRQ_DOVE_I2S1_ERR      (1 + 22)
> -#define IRQ_DOVE_USB_ERR       (1 + 23)
> -#define IRQ_DOVE_USB0          (1 + 24)
> -#define IRQ_DOVE_USB1          (1 + 25)
> -#define IRQ_DOVE_GE00_RX       (1 + 26)
> -#define IRQ_DOVE_GE00_TX       (1 + 27)
> -#define IRQ_DOVE_GE00_MISC     (1 + 28)
> -#define IRQ_DOVE_GE00_SUM      (1 + 29)
> -#define IRQ_DOVE_GE00_ERR      (1 + 30)
> -#define IRQ_DOVE_CRYPTO                (1 + 31)
> -
> -/*
> - * Dove High Interrupt Controller
> - */
> -#define IRQ_DOVE_AC97          (1 + 32)
> -#define IRQ_DOVE_PMU           (1 + 33)
> -#define IRQ_DOVE_CAM           (1 + 34)
> -#define IRQ_DOVE_SDIO0         (1 + 35)
> -#define IRQ_DOVE_SDIO1         (1 + 36)
> -#define IRQ_DOVE_SDIO0_WAKEUP  (1 + 37)
> -#define IRQ_DOVE_SDIO1_WAKEUP  (1 + 38)
> -#define IRQ_DOVE_XOR_00                (1 + 39)
> -#define IRQ_DOVE_XOR_01                (1 + 40)
> -#define IRQ_DOVE_XOR0_ERR      (1 + 41)
> -#define IRQ_DOVE_XOR_10                (1 + 42)
> -#define IRQ_DOVE_XOR_11                (1 + 43)
> -#define IRQ_DOVE_XOR1_ERR      (1 + 44)
> -#define IRQ_DOVE_LCD_DCON      (1 + 45)
> -#define IRQ_DOVE_LCD1          (1 + 46)
> -#define IRQ_DOVE_LCD0          (1 + 47)
> -#define IRQ_DOVE_GPU           (1 + 48)
> -#define IRQ_DOVE_PERFORM_MNTR  (1 + 49)
> -#define IRQ_DOVE_VPRO_DMA1     (1 + 51)
> -#define IRQ_DOVE_SSP_TIMER     (1 + 54)
> -#define IRQ_DOVE_SSP           (1 + 55)
> -#define IRQ_DOVE_MC_L2_ERR     (1 + 56)
> -#define IRQ_DOVE_CRYPTO_ERR    (1 + 59)
> -#define IRQ_DOVE_GPIO_24_31    (1 + 60)
> -#define IRQ_DOVE_HIGH_GPIO     (1 + 61)
> -#define IRQ_DOVE_SATA          (1 + 62)
> -
> -/*
> - * DOVE General Purpose Pins
> - */
> -#define IRQ_DOVE_GPIO_START    65
> -#define NR_GPIO_IRQS           64
> -
> -/*
> - * PMU interrupts
> - */
> -#define IRQ_DOVE_PMU_START     (IRQ_DOVE_GPIO_START + NR_GPIO_IRQS)
> -#define NR_PMU_IRQS            7
> -#define IRQ_DOVE_RTC           (IRQ_DOVE_PMU_START + 5)
> -
> -#define DOVE_NR_IRQS           (IRQ_DOVE_PMU_START + NR_PMU_IRQS)
> -
> -
> -#endif
> diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
> deleted file mode 100644
> index e41bd473abe9..000000000000
> --- a/arch/arm/mach-dove/mpp.c
> +++ /dev/null
> @@ -1,159 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-dove/mpp.c
> - *
> - * MPP functions for Marvell Dove SoCs
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/io.h>
> -#include <plat/mpp.h>
> -#include <plat/orion-gpio.h>
> -#include "dove.h"
> -#include "mpp.h"
> -
> -struct dove_mpp_grp {
> -       int start;
> -       int end;
> -};
> -
> -/* Map a group to a range of GPIO pins in that group */
> -static const struct dove_mpp_grp dove_mpp_grp[] =3D {
> -       [MPP_24_39] =3D {
> -               .start  =3D 24,
> -               .end    =3D 39,
> -       },
> -       [MPP_40_45] =3D {
> -               .start  =3D 40,
> -               .end    =3D 45,
> -       },
> -       [MPP_46_51] =3D {
> -               .start  =3D 46,
> -               .end    =3D 51,
> -       },
> -       [MPP_58_61] =3D {
> -               .start  =3D 58,
> -               .end    =3D 61,
> -       },
> -       [MPP_62_63] =3D {
> -               .start  =3D 62,
> -               .end    =3D 63,
> -       },
> -};
> -
> -/* Enable gpio for a range of pins. mode should be a combination of
> -   GPIO_OUTPUT_OK | GPIO_INPUT_OK */
> -static void __init dove_mpp_gpio_mode(int start, int end, int gpio_mode)
> -{
> -       int i;
> -
> -       for (i =3D start; i <=3D end; i++)
> -               orion_gpio_set_valid(i, gpio_mode);
> -}
> -
> -/* Dump all the extra MPP registers. The platform code will dump the
> -   registers for pins 0-23. */
> -static void __init dove_mpp_dump_regs(void)
> -{
> -       pr_debug("PMU_CTRL4_CTRL: %08x\n",
> -                readl(DOVE_MPP_CTRL4_VIRT_BASE));
> -
> -       pr_debug("PMU_MPP_GENERAL_CTRL: %08x\n",
> -                readl(DOVE_PMU_MPP_GENERAL_CTRL));
> -
> -       pr_debug("MPP_GENERAL: %08x\n", readl(DOVE_MPP_GENERAL_VIRT_BASE)=
);
> -}
> -
> -static void __init dove_mpp_cfg_nfc(int sel)
> -{
> -       u32 mpp_gen_cfg =3D readl(DOVE_MPP_GENERAL_VIRT_BASE);
> -
> -       mpp_gen_cfg &=3D ~0x1;
> -       mpp_gen_cfg |=3D sel;
> -       writel(mpp_gen_cfg, DOVE_MPP_GENERAL_VIRT_BASE);
> -
> -       dove_mpp_gpio_mode(64, 71, GPIO_OUTPUT_OK);
> -}
> -
> -static void __init dove_mpp_cfg_au1(int sel)
> -{
> -       u32 mpp_ctrl4 =3D readl(DOVE_MPP_CTRL4_VIRT_BASE);
> -       u32 ssp_ctrl1 =3D readl(DOVE_SSP_CTRL_STATUS_1);
> -       u32 mpp_gen_ctrl =3D readl(DOVE_MPP_GENERAL_VIRT_BASE);
> -       u32 global_cfg_2 =3D readl(DOVE_GLOBAL_CONFIG_2);
> -
> -       mpp_ctrl4 &=3D ~(DOVE_AU1_GPIO_SEL);
> -       ssp_ctrl1 &=3D ~(DOVE_SSP_ON_AU1);
> -       mpp_gen_ctrl &=3D ~(DOVE_AU1_SPDIFO_GPIO_EN);
> -       global_cfg_2 &=3D ~(DOVE_TWSI_OPTION3_GPIO);
> -
> -       if (!sel || sel =3D=3D 0x2)
> -               dove_mpp_gpio_mode(52, 57, 0);
> -       else
> -               dove_mpp_gpio_mode(52, 57, GPIO_OUTPUT_OK | GPIO_INPUT_OK=
);
> -
> -       if (sel & 0x1) {
> -               global_cfg_2 |=3D DOVE_TWSI_OPTION3_GPIO;
> -               dove_mpp_gpio_mode(56, 57, 0);
> -       }
> -       if (sel & 0x2) {
> -               mpp_gen_ctrl |=3D DOVE_AU1_SPDIFO_GPIO_EN;
> -               dove_mpp_gpio_mode(57, 57, GPIO_OUTPUT_OK | GPIO_INPUT_OK=
);
> -       }
> -       if (sel & 0x4) {
> -               ssp_ctrl1 |=3D DOVE_SSP_ON_AU1;
> -               dove_mpp_gpio_mode(52, 55, 0);
> -       }
> -       if (sel & 0x8)
> -               mpp_ctrl4 |=3D DOVE_AU1_GPIO_SEL;
> -
> -       writel(mpp_ctrl4, DOVE_MPP_CTRL4_VIRT_BASE);
> -       writel(ssp_ctrl1, DOVE_SSP_CTRL_STATUS_1);
> -       writel(mpp_gen_ctrl, DOVE_MPP_GENERAL_VIRT_BASE);
> -       writel(global_cfg_2, DOVE_GLOBAL_CONFIG_2);
> -}
> -
> -/* Configure the group registers, enabling GPIO if sel indicates the
> -   pin is to be used for GPIO */
> -static void __init dove_mpp_conf_grp(unsigned int *mpp_grp_list)
> -{
> -       u32 mpp_ctrl4 =3D readl(DOVE_MPP_CTRL4_VIRT_BASE);
> -       int gpio_mode;
> -
> -       for ( ; *mpp_grp_list; mpp_grp_list++) {
> -               unsigned int num =3D MPP_NUM(*mpp_grp_list);
> -               unsigned int sel =3D MPP_SEL(*mpp_grp_list);
> -
> -               if (num > MPP_GRP_MAX) {
> -                       pr_err("dove: invalid MPP GRP number (%u)\n", num=
);
> -                       continue;
> -               }
> -
> -               mpp_ctrl4 &=3D ~(0x1 << num);
> -               mpp_ctrl4 |=3D sel << num;
> -
> -               gpio_mode =3D sel ? GPIO_OUTPUT_OK | GPIO_INPUT_OK : 0;
> -               dove_mpp_gpio_mode(dove_mpp_grp[num].start,
> -                                  dove_mpp_grp[num].end, gpio_mode);
> -       }
> -       writel(mpp_ctrl4, DOVE_MPP_CTRL4_VIRT_BASE);
> -}
> -
> -/* Configure the various MPP pins on Dove */
> -void __init dove_mpp_conf(unsigned int *mpp_list,
> -                         unsigned int *mpp_grp_list,
> -                         unsigned int grp_au1_52_57,
> -                         unsigned int grp_nfc_64_71)
> -{
> -       dove_mpp_dump_regs();
> -
> -       /* Use platform code for pins 0-23 */
> -       orion_mpp_conf(mpp_list, 0, MPP_MAX, DOVE_MPP_VIRT_BASE);
> -
> -       dove_mpp_conf_grp(mpp_grp_list);
> -       dove_mpp_cfg_au1(grp_au1_52_57);
> -       dove_mpp_cfg_nfc(grp_nfc_64_71);
> -
> -       dove_mpp_dump_regs();
> -}
> diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-dove/mpp.h
> deleted file mode 100644
> index 2e4b89c86ca8..000000000000
> --- a/arch/arm/mach-dove/mpp.h
> +++ /dev/null
> @@ -1,197 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ARCH_DOVE_MPP_CODED_H
> -#define __ARCH_DOVE_MPP_CODED_H
> -
> -#define MPP(_num, _sel, _in, _out) ( \
> -       /* MPP number */                ((_num) & 0xff) | \
> -       /* MPP select value */          (((_sel) & 0xf) << 8) | \
> -       /* may be input signal */       ((!!(_in)) << 12) | \
> -       /* may be output signal */      ((!!(_out)) << 13))
> -
> -#define MPP0_GPIO0             MPP(0, 0x0, 1, 1)
> -#define MPP0_UA2_RTSn          MPP(0, 0x2, 0, 0)
> -#define MPP0_SDIO0_CD          MPP(0, 0x3, 0, 0)
> -#define MPP0_LCD0_PWM          MPP(0, 0xf, 0, 0)
> -
> -#define MPP1_GPIO1             MPP(1, 0x0, 1, 1)
> -#define MPP1_UA2_CTSn          MPP(1, 0x2, 0, 0)
> -#define MPP1_SDIO0_WP          MPP(1, 0x3, 0, 0)
> -#define MPP1_LCD1_PWM          MPP(1, 0xf, 0, 0)
> -
> -#define MPP2_GPIO2             MPP(2, 0x0, 1, 1)
> -#define MPP2_SATA_PRESENT      MPP(2, 0x1, 0, 0)
> -#define MPP2_UA2_TXD           MPP(2, 0x2, 0, 0)
> -#define MPP2_SDIO0_BUS_POWER   MPP(2, 0x3, 0, 0)
> -#define MPP2_UA_RTSn1          MPP(2, 0x4, 0, 0)
> -
> -#define MPP3_GPIO3             MPP(3, 0x0, 1, 1)
> -#define MPP3_SATA_ACT          MPP(3, 0x1, 0, 0)
> -#define MPP3_UA2_RXD           MPP(3, 0x2, 0, 0)
> -#define MPP3_SDIO0_LED_CTRL    MPP(3, 0x3, 0, 0)
> -#define MPP3_UA_CTSn1          MPP(3, 0x4, 0, 0)
> -#define MPP3_SPI_LCD_CS1       MPP(3, 0xf, 0, 0)
> -
> -#define MPP4_GPIO4             MPP(4, 0x0, 1, 1)
> -#define MPP4_UA3_RTSn          MPP(4, 0x2, 0, 0)
> -#define MPP4_SDIO1_CD          MPP(4, 0x3, 0, 0)
> -#define MPP4_SPI_1_MISO                MPP(4, 0x4, 0, 0)
> -
> -#define MPP5_GPIO5             MPP(5, 0x0, 1, 1)
> -#define MPP5_UA3_CTSn          MPP(5, 0x2, 0, 0)
> -#define MPP5_SDIO1_WP          MPP(5, 0x3, 0, 0)
> -#define MPP5_SPI_1_CS          MPP(5, 0x4, 0, 0)
> -
> -#define MPP6_GPIO6             MPP(6, 0x0, 1, 1)
> -#define MPP6_UA3_TXD           MPP(6, 0x2, 0, 0)
> -#define MPP6_SDIO1_BUS_POWER   MPP(6, 0x3, 0, 0)
> -#define MPP6_SPI_1_MOSI                MPP(6, 0x4, 0, 0)
> -
> -#define MPP7_GPIO7             MPP(7, 0x0, 1, 1)
> -#define MPP7_UA3_RXD           MPP(7, 0x2, 0, 0)
> -#define MPP7_SDIO1_LED_CTRL    MPP(7, 0x3, 0, 0)
> -#define MPP7_SPI_1_SCK         MPP(7, 0x4, 0, 0)
> -
> -#define MPP8_GPIO8             MPP(8, 0x0, 1, 1)
> -#define MPP8_WD_RST_OUT                MPP(8, 0x1, 0, 0)
> -
> -#define MPP9_GPIO9             MPP(9, 0x0, 1, 1)
> -#define MPP9_PEX1_CLKREQn      MPP(9, 0x5, 0, 0)
> -
> -#define MPP10_GPIO10           MPP(10, 0x0, 1, 1)
> -#define MPP10_SSP_SCLK         MPP(10, 0x5, 0, 0)
> -
> -#define MPP11_GPIO11           MPP(11, 0x0, 1, 1)
> -#define MPP11_SATA_PRESENT     MPP(11, 0x1, 0, 0)
> -#define MPP11_SATA_ACT         MPP(11, 0x2, 0, 0)
> -#define MPP11_SDIO0_LED_CTRL   MPP(11, 0x3, 0, 0)
> -#define MPP11_SDIO1_LED_CTRL   MPP(11, 0x4, 0, 0)
> -#define MPP11_PEX0_CLKREQn     MPP(11, 0x5, 0, 0)
> -
> -#define MPP12_GPIO12           MPP(12, 0x0, 1, 1)
> -#define MPP12_SATA_ACT         MPP(12, 0x1, 0, 0)
> -#define MPP12_UA2_RTSn         MPP(12, 0x2, 0, 0)
> -#define MPP12_AD0_I2S_EXT_MCLK MPP(12, 0x3, 0, 0)
> -#define MPP12_SDIO1_CD         MPP(12, 0x4, 0, 0)
> -
> -#define MPP13_GPIO13           MPP(13, 0x0, 1, 1)
> -#define MPP13_UA2_CTSn         MPP(13, 0x2, 0, 0)
> -#define MPP13_AD1_I2S_EXT_MCLK MPP(13, 0x3, 0, 0)
> -#define MPP13_SDIO1WP          MPP(13, 0x4, 0, 0)
> -#define MPP13_SSP_EXTCLK       MPP(13, 0x5, 0, 0)
> -
> -#define MPP14_GPIO14           MPP(14, 0x0, 1, 1)
> -#define MPP14_UA2_TXD          MPP(14, 0x2, 0, 0)
> -#define MPP14_SDIO1_BUS_POWER  MPP(14, 0x4, 0, 0)
> -#define MPP14_SSP_RXD          MPP(14, 0x5, 0, 0)
> -
> -#define MPP15_GPIO15           MPP(15, 0x0, 1, 1)
> -#define MPP15_UA2_RXD          MPP(15, 0x2, 0, 0)
> -#define MPP15_SDIO1_LED_CTRL   MPP(15, 0x4, 0, 0)
> -#define MPP15_SSP_SFRM         MPP(15, 0x5, 0, 0)
> -
> -#define MPP16_GPIO16           MPP(16, 0x0, 1, 1)
> -#define MPP16_UA3_RTSn         MPP(16, 0x2, 0, 0)
> -#define MPP16_SDIO0_CD         MPP(16, 0x3, 0, 0)
> -#define MPP16_SPI_LCD_CS1      MPP(16, 0x4, 0, 0)
> -#define MPP16_AC97_SDATA_IN1   MPP(16, 0x5, 0, 0)
> -
> -#define MPP17_GPIO17           MPP(17, 0x0, 1, 1)
> -#define MPP17_AC97_SYSCLK_OUT  MPP(17, 0x1, 0, 0)
> -#define MPP17_UA3_CTSn         MPP(17, 0x2, 0, 0)
> -#define MPP17_SDIO0_WP         MPP(17, 0x3, 0, 0)
> -#define MPP17_TW_SDA2          MPP(17, 0x4, 0, 0)
> -#define MPP17_AC97_SDATA_IN2   MPP(17, 0x5, 0, 0)
> -
> -#define MPP18_GPIO18           MPP(18, 0x0, 1, 1)
> -#define MPP18_UA3_TXD          MPP(18, 0x2, 0, 0)
> -#define MPP18_SDIO0_BUS_POWER  MPP(18, 0x3, 0, 0)
> -#define MPP18_LCD0_PWM         MPP(18, 0x4, 0, 0)
> -#define MPP18_AC_SDATA_IN3     MPP(18, 0x5, 0, 0)
> -
> -#define MPP19_GPIO19           MPP(19, 0x0, 1, 1)
> -#define MPP19_UA3_RXD          MPP(19, 0x2, 0, 0)
> -#define MPP19_SDIO0_LED_CTRL   MPP(19, 0x3, 0, 0)
> -#define MPP19_TW_SCK2          MPP(19, 0x4, 0, 0)
> -
> -#define MPP20_GPIO20           MPP(20, 0x0, 1, 1)
> -#define MPP20_AC97_SYSCLK_OUT  MPP(20, 0x1, 0, 0)
> -#define MPP20_SPI_LCD_MISO     MPP(20, 0x2, 0, 0)
> -#define MPP20_SDIO1_CD         MPP(20, 0x3, 0, 0)
> -#define MPP20_SDIO0_CD         MPP(20, 0x5, 0, 0)
> -#define MPP20_SPI_1_MISO       MPP(20, 0x6, 0, 0)
> -
> -#define MPP21_GPIO21           MPP(21, 0x0, 1, 1)
> -#define MPP21_UA1_RTSn         MPP(21, 0x1, 0, 0)
> -#define MPP21_SPI_LCD_CS0      MPP(21, 0x2, 0, 0)
> -#define MPP21_SDIO1_WP         MPP(21, 0x3, 0, 0)
> -#define MPP21_SSP_SFRM         MPP(21, 0x4, 0, 0)
> -#define MPP21_SDIO0_WP         MPP(21, 0x5, 0, 0)
> -#define MPP21_SPI_1_CS         MPP(21, 0x6, 0, 0)
> -
> -#define MPP22_GPIO22           MPP(22, 0x0, 1, 1)
> -#define MPP22_UA1_CTSn         MPP(22, 0x1, 0, 0)
> -#define MPP22_SPI_LCD_MOSI     MPP(22, 0x2, 0, 0)
> -#define MPP22_SDIO1_BUS_POWER  MPP(22, 0x3, 0, 0)
> -#define MPP22_SSP_TXD          MPP(22, 0x4, 0, 0)
> -#define MPP22_SDIO0_BUS_POWER  MPP(22, 0x5, 0, 0)
> -#define MPP22_SPI_1_MOSI       MPP(22, 0x6, 0, 0)
> -
> -#define MPP23_GPIO23           MPP(23, 0x0, 1, 1)
> -#define MPP23_SPI_LCD_SCK      MPP(23, 0x2, 0, 0)
> -#define MPP23_SDIO1_LED_CTRL   MPP(23, 0x3, 0, 0)
> -#define MPP23_SSP_SCLK         MPP(23, 0x4, 0, 0)
> -#define MPP23_SDIO0_LED_CTRL   MPP(23, 0x5, 0, 0)
> -#define MPP23_SPI_1_SCK                MPP(23, 0x6, 0, 0)
> -
> -#define MPP_MAX                        23
> -
> -#define MPP_GRP(_grp, _mode)   MPP((_grp), (_mode), 0, 0)
> -
> -/* for MPP groups _num is a group index */
> -enum dove_mpp_grp_idx {
> -       MPP_24_39 =3D 2,
> -       MPP_40_45 =3D 0,
> -       MPP_46_51 =3D 1,
> -       MPP_58_61 =3D 5,
> -       MPP_62_63 =3D 4,
> -       MPP_GRP_MAX =3D 5,
> -};
> -
> -#define MPP_GRP_24_39_GPIO             MPP_GRP(MPP_24_39, 0x1)
> -#define MPP_GRP_24_39_CAM              MPP_GRP(MPP_24_39, 0x0)
> -
> -#define MPP_GRP_40_45_GPIO             MPP_GRP(MPP_40_45, 0x1)
> -#define MPP_GRP_40_45_SD0              MPP_GRP(MPP_40_45, 0x0)
> -
> -#define MPP_GRP_46_51_GPIO             MPP_GRP(MPP_46_51, 0x1)
> -#define MPP_GRP_46_51_SD1              MPP_GRP(MPP_46_51, 0x0)
> -
> -#define MPP_GRP_58_61_GPIO             MPP_GRP(MPP_58_61, 0x1)
> -#define MPP_GRP_58_61_SPI              MPP_GRP(MPP_58_61, 0x0)
> -
> -#define MPP_GRP_62_63_GPIO             MPP_GRP(MPP_62_63, 0x1)
> -#define MPP_GRP_62_63_UA1              MPP_GRP(MPP_62_63, 0x0)
> -
> -/* The MPP[64:71] control differs from other groups */
> -#define MPP_GRP_NFC_64_71_GPO          0x1
> -#define MPP_GRP_NFC_64_71_NFC          0x0
> -
> -/*
> - * The MPP[52:57] functionality is encoded by 4 bits in different
> - * registers. The _num field in this case encodes those bits in
> - * correspodence with Table 135 of 88AP510 Functional specification
> - */
> -#define MPP_GRP_AU1_52_57_AU1          0x0
> -#define MPP_GRP_AU1_52_57_AU1_GPIO57   0x2
> -#define MPP_GRP_AU1_52_57_GPIO         0xa
> -#define MPP_GRP_AU1_52_57_TW_GPIO      0xb
> -#define MPP_GRP_AU1_52_57_AU1_SSP      0xc
> -#define MPP_GRP_AU1_52_57_SSP_GPIO     0xe
> -#define MPP_GRP_AU1_52_57_SSP_TW       0xf
> -
> -void dove_mpp_conf(unsigned int *mpp_list,
> -                  unsigned int *mpp_grp_list,
> -                  unsigned int grp_au1_52_57,
> -                  unsigned int grp_nfc_64_71);
> -
> -#endif /* __ARCH_DOVE_MPP_CODED_H */
> diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
> deleted file mode 100644
> index 3044b7e03890..000000000000
> --- a/arch/arm/mach-dove/pcie.c
> +++ /dev/null
> @@ -1,226 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-dove/pcie.c
> - *
> - * PCIe functions for Marvell Dove 88AP510 SoC
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/pci.h>
> -#include <linux/clk.h>
> -#include <video/vga.h>
> -#include <asm/mach/pci.h>
> -#include <asm/mach/arch.h>
> -#include <asm/setup.h>
> -#include <asm/delay.h>
> -#include <plat/pcie.h>
> -#include <plat/addr-map.h>
> -#include "irqs.h"
> -#include "bridge-regs.h"
> -#include "common.h"
> -
> -struct pcie_port {
> -       u8                      index;
> -       u8                      root_bus_nr;
> -       void __iomem            *base;
> -       spinlock_t              conf_lock;
> -       char                    mem_space_name[16];
> -       struct resource         res;
> -};
> -
> -static struct pcie_port pcie_port[2];
> -static int num_pcie_ports;
> -
> -
> -static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
> -{
> -       struct pcie_port *pp;
> -       struct resource realio;
> -
> -       if (nr >=3D num_pcie_ports)
> -               return 0;
> -
> -       pp =3D &pcie_port[nr];
> -       sys->private_data =3D pp;
> -       pp->root_bus_nr =3D sys->busnr;
> -
> -       /*
> -        * Generic PCIe unit setup.
> -        */
> -       orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
> -
> -       orion_pcie_setup(pp->base);
> -
> -       realio.start =3D sys->busnr * SZ_64K;
> -       realio.end =3D realio.start + SZ_64K - 1;
> -       pci_remap_iospace(&realio, pp->index =3D=3D 0 ? DOVE_PCIE0_IO_PHY=
S_BASE :
> -                                                   DOVE_PCIE1_IO_PHYS_BA=
SE);
> -
> -       /*
> -        * IORESOURCE_MEM
> -        */
> -       snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
> -                "PCIe %d MEM", pp->index);
> -       pp->mem_space_name[sizeof(pp->mem_space_name) - 1] =3D 0;
> -       pp->res.name =3D pp->mem_space_name;
> -       if (pp->index =3D=3D 0) {
> -               pp->res.start =3D DOVE_PCIE0_MEM_PHYS_BASE;
> -               pp->res.end =3D pp->res.start + DOVE_PCIE0_MEM_SIZE - 1;
> -       } else {
> -               pp->res.start =3D DOVE_PCIE1_MEM_PHYS_BASE;
> -               pp->res.end =3D pp->res.start + DOVE_PCIE1_MEM_SIZE - 1;
> -       }
> -       pp->res.flags =3D IORESOURCE_MEM;
> -       if (request_resource(&iomem_resource, &pp->res))
> -               panic("Request PCIe Memory resource failed\n");
> -       pci_add_resource_offset(&sys->resources, &pp->res, sys->mem_offse=
t);
> -
> -       return 1;
> -}
> -
> -static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
> -{
> -       /*
> -        * Don't go out when trying to access nonexisting devices
> -        * on the local bus.
> -        */
> -       if (bus =3D=3D pp->root_bus_nr && dev > 1)
> -               return 0;
> -
> -       return 1;
> -}
> -
> -static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> -                       int size, u32 *val)
> -{
> -       struct pci_sys_data *sys =3D bus->sysdata;
> -       struct pcie_port *pp =3D sys->private_data;
> -       unsigned long flags;
> -       int ret;
> -
> -       if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) =3D=3D 0)=
 {
> -               *val =3D 0xffffffff;
> -               return PCIBIOS_DEVICE_NOT_FOUND;
> -       }
> -
> -       spin_lock_irqsave(&pp->conf_lock, flags);
> -       ret =3D orion_pcie_rd_conf(pp->base, bus, devfn, where, size, val=
);
> -       spin_unlock_irqrestore(&pp->conf_lock, flags);
> -
> -       return ret;
> -}
> -
> -static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> -                       int where, int size, u32 val)
> -{
> -       struct pci_sys_data *sys =3D bus->sysdata;
> -       struct pcie_port *pp =3D sys->private_data;
> -       unsigned long flags;
> -       int ret;
> -
> -       if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) =3D=3D 0)
> -               return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -       spin_lock_irqsave(&pp->conf_lock, flags);
> -       ret =3D orion_pcie_wr_conf(pp->base, bus, devfn, where, size, val=
);
> -       spin_unlock_irqrestore(&pp->conf_lock, flags);
> -
> -       return ret;
> -}
> -
> -static struct pci_ops pcie_ops =3D {
> -       .read =3D pcie_rd_conf,
> -       .write =3D pcie_wr_conf,
> -};
> -
> -/*
> - * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, whe=
n it
> - * is operating as a root complex this needs to be switched to
> - * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's=
 on
> - * the device. Decoding setup is handled by the orion code.
> - */
> -static void rc_pci_fixup(struct pci_dev *dev)
> -{
> -       if (dev->bus->parent =3D=3D NULL && dev->devfn =3D=3D 0) {
> -               struct resource *r;
> -
> -               dev->class &=3D 0xff;
> -               dev->class |=3D PCI_CLASS_BRIDGE_HOST << 8;
> -               pci_dev_for_each_resource(dev, r) {
> -                       r->start =3D 0;
> -                       r->end   =3D 0;
> -                       r->flags =3D 0;
> -               }
> -       }
> -}
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup=
);
> -
> -static int __init
> -dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
> -{
> -       struct pci_sys_data *sys =3D pci_host_bridge_priv(bridge);
> -
> -       if (nr >=3D num_pcie_ports) {
> -               BUG();
> -               return -EINVAL;
> -       }
> -
> -       list_splice_init(&sys->resources, &bridge->windows);
> -       bridge->dev.parent =3D NULL;
> -       bridge->sysdata =3D sys;
> -       bridge->busnr =3D sys->busnr;
> -       bridge->ops =3D &pcie_ops;
> -
> -       return pci_scan_root_bus_bridge(bridge);
> -}
> -
> -static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, =
u8 pin)
> -{
> -       struct pci_sys_data *sys =3D dev->sysdata;
> -       struct pcie_port *pp =3D sys->private_data;
> -
> -       return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
> -}
> -
> -static struct hw_pci dove_pci __initdata =3D {
> -       .nr_controllers =3D 2,
> -       .setup          =3D dove_pcie_setup,
> -       .scan           =3D dove_pcie_scan_bus,
> -       .map_irq        =3D dove_pcie_map_irq,
> -};
> -
> -static void __init add_pcie_port(int index, void __iomem *base)
> -{
> -       printk(KERN_INFO "Dove PCIe port %d: ", index);
> -
> -       if (orion_pcie_link_up(base)) {
> -               struct pcie_port *pp =3D &pcie_port[num_pcie_ports++];
> -               struct clk *clk =3D clk_get_sys("pcie", (index ? "1" : "0=
"));
> -
> -               if (!IS_ERR(clk))
> -                       clk_prepare_enable(clk);
> -
> -               printk(KERN_INFO "link up\n");
> -
> -               pp->index =3D index;
> -               pp->root_bus_nr =3D -1;
> -               pp->base =3D base;
> -               spin_lock_init(&pp->conf_lock);
> -               memset(&pp->res, 0, sizeof(pp->res));
> -       } else {
> -               printk(KERN_INFO "link down, ignoring\n");
> -       }
> -}
> -
> -void __init dove_pcie_init(int init_port0, int init_port1)
> -{
> -       vga_base =3D DOVE_PCIE0_MEM_PHYS_BASE;
> -
> -       if (init_port0)
> -               add_pcie_port(0, DOVE_PCIE0_VIRT_BASE);
> -
> -       if (init_port1)
> -               add_pcie_port(1, DOVE_PCIE1_VIRT_BASE);
> -
> -       pci_common_init(&dove_pci);
> -}
> diff --git a/arch/arm/mach-dove/pm.h b/arch/arm/mach-dove/pm.h
> deleted file mode 100644
> index a4c3aba1e2d0..000000000000
> --- a/arch/arm/mach-dove/pm.h
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#ifndef __ASM_ARCH_PM_H
> -#define __ASM_ARCH_PM_H
> -
> -#include <asm/errno.h>
> -#include "irqs.h"
> -
> -#define CLOCK_GATING_CONTROL   (DOVE_PMU_VIRT_BASE + 0x38)
> -#define  CLOCK_GATING_BIT_USB0         0
> -#define  CLOCK_GATING_BIT_USB1         1
> -#define  CLOCK_GATING_BIT_GBE          2
> -#define  CLOCK_GATING_BIT_SATA         3
> -#define  CLOCK_GATING_BIT_PCIE0                4
> -#define  CLOCK_GATING_BIT_PCIE1                5
> -#define  CLOCK_GATING_BIT_SDIO0                8
> -#define  CLOCK_GATING_BIT_SDIO1                9
> -#define  CLOCK_GATING_BIT_NAND         10
> -#define  CLOCK_GATING_BIT_CAMERA       11
> -#define  CLOCK_GATING_BIT_I2S0         12
> -#define  CLOCK_GATING_BIT_I2S1         13
> -#define  CLOCK_GATING_BIT_CRYPTO       15
> -#define  CLOCK_GATING_BIT_AC97         21
> -#define  CLOCK_GATING_BIT_PDMA         22
> -#define  CLOCK_GATING_BIT_XOR0         23
> -#define  CLOCK_GATING_BIT_XOR1         24
> -#define  CLOCK_GATING_BIT_GIGA_PHY     30
> -#define  CLOCK_GATING_USB0_MASK                (1 << CLOCK_GATING_BIT_US=
B0)
> -#define  CLOCK_GATING_USB1_MASK                (1 << CLOCK_GATING_BIT_US=
B1)
> -#define  CLOCK_GATING_GBE_MASK         (1 << CLOCK_GATING_BIT_GBE)
> -#define  CLOCK_GATING_SATA_MASK                (1 << CLOCK_GATING_BIT_SA=
TA)
> -#define  CLOCK_GATING_PCIE0_MASK       (1 << CLOCK_GATING_BIT_PCIE0)
> -#define  CLOCK_GATING_PCIE1_MASK       (1 << CLOCK_GATING_BIT_PCIE1)
> -#define  CLOCK_GATING_SDIO0_MASK       (1 << CLOCK_GATING_BIT_SDIO0)
> -#define  CLOCK_GATING_SDIO1_MASK       (1 << CLOCK_GATING_BIT_SDIO1)
> -#define  CLOCK_GATING_NAND_MASK                (1 << CLOCK_GATING_BIT_NA=
ND)
> -#define  CLOCK_GATING_CAMERA_MASK      (1 << CLOCK_GATING_BIT_CAMERA)
> -#define  CLOCK_GATING_I2S0_MASK                (1 << CLOCK_GATING_BIT_I2=
S0)
> -#define  CLOCK_GATING_I2S1_MASK                (1 << CLOCK_GATING_BIT_I2=
S1)
> -#define  CLOCK_GATING_CRYPTO_MASK      (1 << CLOCK_GATING_BIT_CRYPTO)
> -#define  CLOCK_GATING_AC97_MASK                (1 << CLOCK_GATING_BIT_AC=
97)
> -#define  CLOCK_GATING_PDMA_MASK                (1 << CLOCK_GATING_BIT_PD=
MA)
> -#define  CLOCK_GATING_XOR0_MASK                (1 << CLOCK_GATING_BIT_XO=
R0)
> -#define  CLOCK_GATING_XOR1_MASK                (1 << CLOCK_GATING_BIT_XO=
R1)
> -#define  CLOCK_GATING_GIGA_PHY_MASK    (1 << CLOCK_GATING_BIT_GIGA_PHY)
> -
> -#define PMU_INTERRUPT_CAUSE    (DOVE_PMU_VIRT_BASE + 0x50)
> -
> -#define  PMU_SW_RST_VIDEO_MASK         BIT(16)
> -#define  PMU_SW_RST_GPU_MASK           BIT(18)
> -
> -#define  PMU_PWR_GPU_PWR_DWN_MASK      BIT(2)
> -#define  PMU_PWR_VPU_PWR_DWN_MASK      BIT(3)
> -
> -#define  PMU_ISO_VIDEO_MASK            BIT(0)
> -#define  PMU_ISO_GPU_MASK              BIT(1)
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfi=
g
> deleted file mode 100644
> index 98b35f5d05ba..000000000000
> --- a/arch/arm/mach-mv78xx0/Kconfig
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -menuconfig ARCH_MV78XX0
> -       bool "Marvell MV78xx0 (DEPRECATED)"
> -       depends on ARCH_MULTI_V5
> -       depends on CPU_LITTLE_ENDIAN
> -       depends on ATAGS
> -       select CPU_FEROCEON
> -       select GPIOLIB
> -       select GPIOLIB_LEGACY
> -       select MVEBU_MBUS
> -       select FORCE_PCI
> -       select PLAT_ORION_LEGACY
> -       help
> -         Support for the following Marvell MV78xx0 series SoCs:
> -         MV781x0, MV782x0.
> -
> -         This platform is scheduled for removal in early 2027.
> -
> -if ARCH_MV78XX0
> -
> -config MACH_TERASTATION_WXL
> -       bool "Buffalo WLX (Terastation Duo) NAS"
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         Buffalo WXL Nas.
> -
> -endif
> diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-mv78xx0/Makef=
ile
> deleted file mode 100644
> index ddee6ae501bb..000000000000
> --- a/arch/arm/mach-mv78xx0/Makefile
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D -I$(srctree)/arch/arm/plat-orion/include
> -
> -obj-y                          +=3D common.o mpp.o irq.o pcie.o
> -obj-$(CONFIG_MACH_TERASTATION_WXL) +=3D buffalo-wxl-setup.o
> diff --git a/arch/arm/mach-mv78xx0/bridge-regs.h b/arch/arm/mach-mv78xx0/=
bridge-regs.h
> deleted file mode 100644
> index d57ac967c4b3..000000000000
> --- a/arch/arm/mach-mv78xx0/bridge-regs.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#ifndef __ASM_ARCH_BRIDGE_REGS_H
> -#define __ASM_ARCH_BRIDGE_REGS_H
> -
> -#include "mv78xx0.h"
> -
> -#define CPU_CONTROL            (BRIDGE_VIRT_BASE + 0x0104)
> -#define L2_WRITETHROUGH                0x00020000
> -
> -#define RSTOUTn_MASK           (BRIDGE_VIRT_BASE + 0x0108)
> -#define RSTOUTn_MASK_PHYS      (BRIDGE_PHYS_BASE + 0x0108)
> -#define SOFT_RESET_OUT_EN      0x00000004
> -
> -#define SYSTEM_SOFT_RESET      (BRIDGE_VIRT_BASE + 0x010c)
> -#define SOFT_RESET             0x00000001
> -
> -#define BRIDGE_INT_TIMER1_CLR  (~0x0004)
> -
> -#define IRQ_VIRT_BASE          (BRIDGE_VIRT_BASE + 0x0200)
> -#define IRQ_CAUSE_ERR_OFF      0x0000
> -#define IRQ_CAUSE_LOW_OFF      0x0004
> -#define IRQ_CAUSE_HIGH_OFF     0x0008
> -#define IRQ_MASK_ERR_OFF       0x000c
> -#define IRQ_MASK_LOW_OFF       0x0010
> -#define IRQ_MASK_HIGH_OFF      0x0014
> -
> -#define TIMER_VIRT_BASE                (BRIDGE_VIRT_BASE + 0x0300)
> -#define TIMER_PHYS_BASE                (BRIDGE_PHYS_BASE + 0x0300)
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv=
78xx0/buffalo-wxl-setup.c
> deleted file mode 100644
> index 3b2e381b7383..000000000000
> --- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> - *
> - * Buffalo WXL (Terastation Duo) Setup routines
> - *
> - * sebastien requiem <sebastien@requiem.fr>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/ata_platform.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/ethtool.h>
> -#include <linux/i2c.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include "mv78xx0.h"
> -#include "common.h"
> -#include "mpp.h"
> -
> -
> -#define TSWXL_AUTO_SWITCH      15
> -#define TSWXL_USB_POWER1       30
> -#define TSWXL_USB_POWER2       31
> -
> -
> -/* This arch has 2 Giga Ethernet */
> -
> -static struct mv643xx_eth_platform_data db78x00_ge00_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(0),
> -};
> -
> -static struct mv643xx_eth_platform_data db78x00_ge01_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -
> -/* 2 SATA controller supporting HotPlug */
> -
> -static struct mv_sata_platform_data db78x00_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -static struct i2c_board_info __initdata db78x00_i2c_rtc =3D {
> -       I2C_BOARD_INFO("rs5c372a", 0x32),
> -};
> -
> -
> -static unsigned int wxl_mpp_config[] __initdata =3D {
> -       MPP0_GE1_TXCLK,
> -       MPP1_GE1_TXCTL,
> -       MPP2_GE1_RXCTL,
> -       MPP3_GE1_RXCLK,
> -       MPP4_GE1_TXD0,
> -       MPP5_GE1_TXD1,
> -       MPP6_GE1_TXD2,
> -       MPP7_GE1_TXD3,
> -       MPP8_GE1_RXD0,
> -       MPP9_GE1_RXD1,
> -       MPP10_GE1_RXD2,
> -       MPP11_GE1_RXD3,
> -       MPP12_GPIO,
> -       MPP13_GPIO,
> -       MPP14_GPIO,
> -       MPP15_GPIO,
> -       MPP16_GPIO,
> -       MPP17_GPIO,
> -       MPP18_GPIO,
> -       MPP19_GPIO,
> -       MPP20_GPIO,
> -       MPP21_GPIO,
> -       MPP22_GPIO,
> -       MPP23_GPIO,
> -       MPP24_UA2_TXD,
> -       MPP25_UA2_RXD,
> -       MPP26_UA2_CTSn,
> -       MPP27_UA2_RTSn,
> -       MPP28_GPIO,
> -       MPP29_GPIO,
> -       MPP30_GPIO,
> -       MPP31_GPIO,
> -       MPP32_GPIO,
> -       MPP33_GPIO,
> -       MPP34_GPIO,
> -       MPP35_GPIO,
> -       MPP36_GPIO,
> -       MPP37_GPIO,
> -       MPP38_GPIO,
> -       MPP39_GPIO,
> -       MPP40_GPIO,
> -       MPP41_GPIO,
> -       MPP42_GPIO,
> -       MPP43_GPIO,
> -       MPP44_GPIO,
> -       MPP45_GPIO,
> -       MPP46_GPIO,
> -       MPP47_GPIO,
> -       MPP48_GPIO,
> -       MPP49_GPIO,
> -       0
> -};
> -
> -static struct gpio_keys_button tswxl_buttons[] =3D {
> -       {
> -               .code      =3D KEY_OPTION,
> -               .gpio      =3D TSWXL_AUTO_SWITCH,
> -               .desc      =3D "Power-auto Switch",
> -               .active_low     =3D 1,
> -       }
> -};
> -
> -static struct gpio_keys_platform_data tswxl_button_data =3D {
> -       .buttons        =3D tswxl_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(tswxl_buttons),
> -};
> -
> -static struct platform_device tswxl_button_device =3D {
> -       .name      =3D "gpio-keys",
> -       .id          =3D -1,
> -       .num_resources  =3D 0,
> -       .dev        =3D {
> -               .platform_data  =3D &tswxl_button_data,
> -       },
> -};
> -
> -static void __init wxl_init(void)
> -{
> -       /*
> -        * Basic MV78xx0 setup. Needs to be called early.
> -        */
> -       mv78xx0_init();
> -       mv78xx0_mpp_conf(wxl_mpp_config);
> -
> -       /*
> -        * Partition on-chip peripherals between the two CPU cores.
> -        */
> -       mv78xx0_ehci0_init();
> -       mv78xx0_ehci1_init();
> -       mv78xx0_ge00_init(&db78x00_ge00_data);
> -       mv78xx0_ge01_init(&db78x00_ge01_data);
> -       mv78xx0_sata_init(&db78x00_sata_data);
> -       mv78xx0_uart0_init();
> -       mv78xx0_uart1_init();
> -       mv78xx0_uart2_init();
> -       mv78xx0_uart3_init();
> -       mv78xx0_xor_init();
> -       mv78xx0_crypto_init();
> -       mv78xx0_i2c_init();
> -       i2c_register_board_info(0, &db78x00_i2c_rtc, 1);
> -
> -       //enable both usb ports
> -       gpio_direction_output(TSWXL_USB_POWER1, 1);
> -       gpio_direction_output(TSWXL_USB_POWER2, 1);
> -
> -       //enable rear switch
> -       platform_device_register(&tswxl_button_device);
> -}
> -
> -static int __init wxl_pci_init(void)
> -{
> -       if (machine_is_terastation_wxl() && mv78xx0_core_index() =3D=3D 0=
)
> -                mv78xx0_pcie_init(1, 1);
> -
> -       return 0;
> -}
> -subsys_initcall(wxl_pci_init);
> -
> -MACHINE_START(TERASTATION_WXL, "Buffalo Nas WXL")
> -       /* Maintainer: Sebastien Requiem <sebastien@requiem.fr> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D MV78XX0_NR_IRQS,
> -       .init_machine   =3D wxl_init,
> -       .map_io         =3D mv78xx0_map_io,
> -       .init_early     =3D mv78xx0_init_early,
> -       .init_irq       =3D mv78xx0_init_irq,
> -       .init_time      =3D mv78xx0_timer_init,
> -       .restart        =3D mv78xx0_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/commo=
n.c
> deleted file mode 100644
> index 679753fcc0ef..000000000000
> --- a/arch/arm/mach-mv78xx0/common.c
> +++ /dev/null
> @@ -1,444 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-mv78xx0/common.c
> - *
> - * Core functions for Marvell MV78xx0 SoCs
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/platform_device.h>
> -#include <linux/serial_8250.h>
> -#include <linux/ata_platform.h>
> -#include <linux/clk-provider.h>
> -#include <linux/ethtool.h>
> -#include <asm/hardware/cache-feroceon-l2.h>
> -#include <asm/mach/map.h>
> -#include <asm/mach/time.h>
> -#include <linux/platform_data/usb-ehci-orion.h>
> -#include <linux/platform_data/mtd-orion_nand.h>
> -#include <plat/time.h>
> -#include <plat/common.h>
> -#include <plat/addr-map.h>
> -#include "mv78xx0.h"
> -#include "bridge-regs.h"
> -#include "common.h"
> -
> -static int get_tclk(void);
> -
> -/***********************************************************************=
******
> - * Common bits
> - ***********************************************************************=
*****/
> -int mv78xx0_core_index(void)
> -{
> -       u32 extra;
> -
> -       /*
> -        * Read Extra Features register.
> -        */
> -       __asm__("mrc p15, 1, %0, c15, c1, 0" : "=3Dr" (extra));
> -
> -       return !!(extra & 0x00004000);
> -}
> -
> -static int get_hclk(void)
> -{
> -       int hclk;
> -
> -       /*
> -        * HCLK tick rate is configured by DEV_D[7:5] pins.
> -        */
> -       switch ((readl(SAMPLE_AT_RESET_LOW) >> 5) & 7) {
> -       case 0:
> -               hclk =3D 166666667;
> -               break;
> -       case 1:
> -               hclk =3D 200000000;
> -               break;
> -       case 2:
> -               hclk =3D 266666667;
> -               break;
> -       case 3:
> -               hclk =3D 333333333;
> -               break;
> -       case 4:
> -               hclk =3D 400000000;
> -               break;
> -       default:
> -               panic("unknown HCLK PLL setting: %.8x\n",
> -                       readl(SAMPLE_AT_RESET_LOW));
> -       }
> -
> -       return hclk;
> -}
> -
> -static void get_pclk_l2clk(int hclk, int core_index, int *pclk, int *l2c=
lk)
> -{
> -       u32 cfg;
> -
> -       /*
> -        * Core #0 PCLK/L2CLK is configured by bits [13:8], core #1
> -        * PCLK/L2CLK by bits [19:14].
> -        */
> -       if (core_index =3D=3D 0) {
> -               cfg =3D (readl(SAMPLE_AT_RESET_LOW) >> 8) & 0x3f;
> -       } else {
> -               cfg =3D (readl(SAMPLE_AT_RESET_LOW) >> 14) & 0x3f;
> -       }
> -
> -       /*
> -        * Bits [11:8] ([17:14] for core #1) configure the PCLK:HCLK
> -        * ratio (1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6).
> -        */
> -       *pclk =3D ((u64)hclk * (2 + (cfg & 0xf))) >> 1;
> -
> -       /*
> -        * Bits [13:12] ([19:18] for core #1) configure the PCLK:L2CLK
> -        * ratio (1, 2, 3).
> -        */
> -       *l2clk =3D *pclk / (((cfg >> 4) & 3) + 1);
> -}
> -
> -static int get_tclk(void)
> -{
> -       int tclk_freq;
> -
> -       /*
> -        * TCLK tick rate is configured by DEV_A[2:0] strap pins.
> -        */
> -       switch ((readl(SAMPLE_AT_RESET_HIGH) >> 6) & 7) {
> -       case 1:
> -               tclk_freq =3D 166666667;
> -               break;
> -       case 3:
> -               tclk_freq =3D 200000000;
> -               break;
> -       default:
> -               panic("unknown TCLK PLL setting: %.8x\n",
> -                       readl(SAMPLE_AT_RESET_HIGH));
> -       }
> -
> -       return tclk_freq;
> -}
> -
> -
> -/***********************************************************************=
******
> - * I/O Address Mapping
> - ***********************************************************************=
*****/
> -static struct map_desc mv78xx0_io_desc[] __initdata =3D {
> -       {
> -               .virtual        =3D (unsigned long) MV78XX0_CORE_REGS_VIR=
T_BASE,
> -               .pfn            =3D 0,
> -               .length         =3D MV78XX0_CORE_REGS_SIZE,
> -               .type           =3D MT_DEVICE,
> -       }, {
> -               .virtual        =3D (unsigned long) MV78XX0_REGS_VIRT_BAS=
E,
> -               .pfn            =3D __phys_to_pfn(MV78XX0_REGS_PHYS_BASE)=
,
> -               .length         =3D MV78XX0_REGS_SIZE,
> -               .type           =3D MT_DEVICE,
> -       },
> -};
> -
> -void __init mv78xx0_map_io(void)
> -{
> -       unsigned long phys;
> -
> -       /*
> -        * Map the right set of per-core registers depending on
> -        * which core we are running on.
> -        */
> -       if (mv78xx0_core_index() =3D=3D 0) {
> -               phys =3D MV78XX0_CORE0_REGS_PHYS_BASE;
> -       } else {
> -               phys =3D MV78XX0_CORE1_REGS_PHYS_BASE;
> -       }
> -       mv78xx0_io_desc[0].pfn =3D __phys_to_pfn(phys);
> -
> -       iotable_init(mv78xx0_io_desc, ARRAY_SIZE(mv78xx0_io_desc));
> -}
> -
> -
> -/***********************************************************************=
******
> - * CLK tree
> - ***********************************************************************=
*****/
> -static struct clk *tclk;
> -
> -static void __init clk_init(void)
> -{
> -       tclk =3D clk_register_fixed_rate(NULL, "tclk", NULL, 0, get_tclk(=
));
> -
> -       orion_clkdev_init(tclk);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ehci0_init(void)
> -{
> -       orion_ehci_init(USB0_PHYS_BASE, IRQ_MV78XX0_USB_0, EHCI_PHY_NA);
> -}
> -
> -
> -/***********************************************************************=
******
> - * EHCI1
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ehci1_init(void)
> -{
> -       orion_ehci_1_init(USB1_PHYS_BASE, IRQ_MV78XX0_USB_1);
> -}
> -
> -
> -/***********************************************************************=
******
> - * EHCI2
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ehci2_init(void)
> -{
> -       orion_ehci_2_init(USB2_PHYS_BASE, IRQ_MV78XX0_USB_2);
> -}
> -
> -
> -/***********************************************************************=
******
> - * GE00
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ge00_init(struct mv643xx_eth_platform_data *eth_data=
)
> -{
> -       orion_ge00_init(eth_data,
> -                       GE00_PHYS_BASE, IRQ_MV78XX0_GE00_SUM,
> -                       IRQ_MV78XX0_GE_ERR,
> -                       MV643XX_TX_CSUM_DEFAULT_LIMIT);
> -}
> -
> -
> -/***********************************************************************=
******
> - * GE01
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ge01_init(struct mv643xx_eth_platform_data *eth_data=
)
> -{
> -       orion_ge01_init(eth_data,
> -                       GE01_PHYS_BASE, IRQ_MV78XX0_GE01_SUM,
> -                       MV643XX_TX_CSUM_DEFAULT_LIMIT);
> -}
> -
> -
> -/***********************************************************************=
******
> - * GE10
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ge10_init(struct mv643xx_eth_platform_data *eth_data=
)
> -{
> -       u32 dev, rev;
> -
> -       /*
> -        * On the Z0, ge10 and ge11 are internally connected back
> -        * to back, and not brought out.
> -        */
> -       mv78xx0_pcie_id(&dev, &rev);
> -       if (dev =3D=3D MV78X00_Z0_DEV_ID) {
> -               eth_data->phy_addr =3D MV643XX_ETH_PHY_NONE;
> -               eth_data->speed =3D SPEED_1000;
> -               eth_data->duplex =3D DUPLEX_FULL;
> -       }
> -
> -       orion_ge10_init(eth_data, GE10_PHYS_BASE, IRQ_MV78XX0_GE10_SUM);
> -}
> -
> -
> -/***********************************************************************=
******
> - * GE11
> - ***********************************************************************=
*****/
> -void __init mv78xx0_ge11_init(struct mv643xx_eth_platform_data *eth_data=
)
> -{
> -       u32 dev, rev;
> -
> -       /*
> -        * On the Z0, ge10 and ge11 are internally connected back
> -        * to back, and not brought out.
> -        */
> -       mv78xx0_pcie_id(&dev, &rev);
> -       if (dev =3D=3D MV78X00_Z0_DEV_ID) {
> -               eth_data->phy_addr =3D MV643XX_ETH_PHY_NONE;
> -               eth_data->speed =3D SPEED_1000;
> -               eth_data->duplex =3D DUPLEX_FULL;
> -       }
> -
> -       orion_ge11_init(eth_data, GE11_PHYS_BASE, IRQ_MV78XX0_GE11_SUM);
> -}
> -
> -/***********************************************************************=
******
> - * I2C
> - ***********************************************************************=
*****/
> -void __init mv78xx0_i2c_init(void)
> -{
> -       orion_i2c_init(I2C_0_PHYS_BASE, IRQ_MV78XX0_I2C_0, 8);
> -       orion_i2c_1_init(I2C_1_PHYS_BASE, IRQ_MV78XX0_I2C_1, 8);
> -}
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -void __init mv78xx0_sata_init(struct mv_sata_platform_data *sata_data)
> -{
> -       orion_sata_init(sata_data, SATA_PHYS_BASE, IRQ_MV78XX0_SATA);
> -}
> -
> -
> -/***********************************************************************=
******
> - * UART0
> - ***********************************************************************=
*****/
> -void __init mv78xx0_uart0_init(void)
> -{
> -       orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
> -                        IRQ_MV78XX0_UART_0, tclk);
> -}
> -
> -
> -/***********************************************************************=
******
> - * UART1
> - ***********************************************************************=
*****/
> -void __init mv78xx0_uart1_init(void)
> -{
> -       orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
> -                        IRQ_MV78XX0_UART_1, tclk);
> -}
> -
> -
> -/***********************************************************************=
******
> - * UART2
> - ***********************************************************************=
*****/
> -void __init mv78xx0_uart2_init(void)
> -{
> -       orion_uart2_init(UART2_VIRT_BASE, UART2_PHYS_BASE,
> -                        IRQ_MV78XX0_UART_2, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * UART3
> - ***********************************************************************=
*****/
> -void __init mv78xx0_uart3_init(void)
> -{
> -       orion_uart3_init(UART3_VIRT_BASE, UART3_PHYS_BASE,
> -                        IRQ_MV78XX0_UART_3, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * Time handling
> - ***********************************************************************=
*****/
> -void __init mv78xx0_init_early(void)
> -{
> -       orion_time_set_base(TIMER_VIRT_BASE);
> -       if (mv78xx0_core_index() =3D=3D 0)
> -               mvebu_mbus_init("marvell,mv78xx0-mbus",
> -                               BRIDGE_WINS_CPU0_BASE, BRIDGE_WINS_SZ,
> -                               DDR_WINDOW_CPU0_BASE, DDR_WINDOW_CPU_SZ);
> -       else
> -               mvebu_mbus_init("marvell,mv78xx0-mbus",
> -                               BRIDGE_WINS_CPU1_BASE, BRIDGE_WINS_SZ,
> -                               DDR_WINDOW_CPU1_BASE, DDR_WINDOW_CPU_SZ);
> -}
> -
> -void __ref mv78xx0_timer_init(void)
> -{
> -       orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
> -                       IRQ_MV78XX0_TIMER_1, get_tclk());
> -}
> -
> -/***********************************************************************=
*****
> -* XOR engine
> -************************************************************************=
****/
> -void __init mv78xx0_xor_init(void)
> -{
> -       orion_xor0_init(XOR_PHYS_BASE,
> -               XOR_PHYS_BASE + 0x200,
> -               IRQ_MV78XX0_XOR_0, IRQ_MV78XX0_XOR_1);
> -}
> -
> -/***********************************************************************=
*****
> - * Cryptographic Engines and Security Accelerator (CESA)
> -************************************************************************=
****/
> -void __init mv78xx0_crypto_init(void)
> -{
> -       mvebu_mbus_add_window_by_id(MV78XX0_MBUS_SRAM_TARGET,
> -                               MV78XX0_MBUS_SRAM_ATTR,
> -                               MV78XX0_SRAM_PHYS_BASE,
> -                       MV78XX0_SRAM_SIZE);
> -       orion_crypto_init(CRYPTO_PHYS_BASE, MV78XX0_SRAM_PHYS_BASE,
> -               SZ_8K, IRQ_MV78XX0_CRYPTO);
> -}
> -
> -
> -/***********************************************************************=
******
> - * General
> - ***********************************************************************=
*****/
> -static char * __init mv78xx0_id(void)
> -{
> -       u32 dev, rev;
> -
> -       mv78xx0_pcie_id(&dev, &rev);
> -
> -       if (dev =3D=3D MV78X00_Z0_DEV_ID) {
> -               if (rev =3D=3D MV78X00_REV_Z0)
> -                       return "MV78X00-Z0";
> -               else
> -                       return "MV78X00-Rev-Unsupported";
> -       } else if (dev =3D=3D MV78100_DEV_ID) {
> -               if (rev =3D=3D MV78100_REV_A0)
> -                       return "MV78100-A0";
> -               else if (rev =3D=3D MV78100_REV_A1)
> -                       return "MV78100-A1";
> -               else
> -                       return "MV78100-Rev-Unsupported";
> -       } else if (dev =3D=3D MV78200_DEV_ID) {
> -               if (rev =3D=3D MV78100_REV_A0)
> -                       return "MV78200-A0";
> -               else
> -                       return "MV78200-Rev-Unsupported";
> -       } else {
> -               return "Device-Unknown";
> -       }
> -}
> -
> -static int __init is_l2_writethrough(void)
> -{
> -       return !!(readl(CPU_CONTROL) & L2_WRITETHROUGH);
> -}
> -
> -void __init mv78xx0_init(void)
> -{
> -       int core_index;
> -       int hclk;
> -       int pclk;
> -       int l2clk;
> -
> -       core_index =3D mv78xx0_core_index();
> -       hclk =3D get_hclk();
> -       get_pclk_l2clk(hclk, core_index, &pclk, &l2clk);
> -
> -       printk(KERN_INFO "%s ", mv78xx0_id());
> -       printk("core #%d, ", core_index);
> -       printk("PCLK =3D %dMHz, ", (pclk + 499999) / 1000000);
> -       printk("L2 =3D %dMHz, ", (l2clk + 499999) / 1000000);
> -       printk("HCLK =3D %dMHz, ", (hclk + 499999) / 1000000);
> -       printk("TCLK =3D %dMHz\n", (get_tclk() + 499999) / 1000000);
> -
> -       if (IS_ENABLED(CONFIG_CACHE_FEROCEON_L2))
> -               feroceon_l2_init(is_l2_writethrough());
> -
> -       /* Setup root of clk tree */
> -       clk_init();
> -}
> -
> -void mv78xx0_restart(enum reboot_mode mode, const char *cmd)
> -{
> -       /*
> -        * Enable soft reset to assert RSTOUTn.
> -        */
> -       writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
> -
> -       /*
> -        * Assert soft reset.
> -        */
> -       writel(SOFT_RESET, SYSTEM_SOFT_RESET);
> -
> -       while (1)
> -               ;
> -}
> diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/commo=
n.h
> deleted file mode 100644
> index 9f1dfd595003..000000000000
> --- a/arch/arm/mach-mv78xx0/common.h
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * arch/arm/mach-mv78xx0/common.h
> - *
> - * Core functions for Marvell MV78xx0 SoCs
> - */
> -
> -#ifndef __ARCH_MV78XX0_COMMON_H
> -#define __ARCH_MV78XX0_COMMON_H
> -
> -#include <linux/reboot.h>
> -
> -struct mv643xx_eth_platform_data;
> -struct mv_sata_platform_data;
> -
> -/*
> - * Basic MV78xx0 init functions used early by machine-setup.
> - */
> -int mv78xx0_core_index(void);
> -void mv78xx0_map_io(void);
> -void mv78xx0_init(void);
> -void mv78xx0_init_early(void);
> -void mv78xx0_init_irq(void);
> -
> -void mv78xx0_setup_cpu_mbus(void);
> -void mv78xx0_setup_pcie_io_win(int window, u32 base, u32 size,
> -                              int maj, int min);
> -void mv78xx0_setup_pcie_mem_win(int window, u32 base, u32 size,
> -                               int maj, int min);
> -
> -void mv78xx0_pcie_id(u32 *dev, u32 *rev);
> -
> -void mv78xx0_ehci0_init(void);
> -void mv78xx0_ehci1_init(void);
> -void mv78xx0_ehci2_init(void);
> -void mv78xx0_ge00_init(struct mv643xx_eth_platform_data *eth_data);
> -void mv78xx0_ge01_init(struct mv643xx_eth_platform_data *eth_data);
> -void mv78xx0_ge10_init(struct mv643xx_eth_platform_data *eth_data);
> -void mv78xx0_ge11_init(struct mv643xx_eth_platform_data *eth_data);
> -void mv78xx0_pcie_init(int init_port0, int init_port1);
> -void mv78xx0_sata_init(struct mv_sata_platform_data *sata_data);
> -void mv78xx0_uart0_init(void);
> -void mv78xx0_uart1_init(void);
> -void mv78xx0_uart2_init(void);
> -void mv78xx0_uart3_init(void);
> -void mv78xx0_xor_init(void);
> -void mv78xx0_crypto_init(void);
> -void mv78xx0_i2c_init(void);
> -void mv78xx0_restart(enum reboot_mode, const char *);
> -
> -extern void mv78xx0_timer_init(void);
> -
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
> deleted file mode 100644
> index 6e42f6446637..000000000000
> --- a/arch/arm/mach-mv78xx0/irq.c
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-mv78xx0/irq.c
> - *
> - * MV78xx0 IRQ handling.
> - */
> -#include <linux/gpio/consumer.h>
> -#include <linux/kernel.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -#include <asm/exception.h>
> -#include <plat/orion-gpio.h>
> -#include <plat/irq.h>
> -#include "bridge-regs.h"
> -#include "common.h"
> -
> -static int __initdata gpio0_irqs[4] =3D {
> -       IRQ_MV78XX0_GPIO_0_7,
> -       IRQ_MV78XX0_GPIO_8_15,
> -       IRQ_MV78XX0_GPIO_16_23,
> -       IRQ_MV78XX0_GPIO_24_31,
> -};
> -
> -static void __iomem *mv78xx0_irq_base =3D IRQ_VIRT_BASE;
> -
> -static asmlinkage void
> -__exception_irq_entry mv78xx0_legacy_handle_irq(struct pt_regs *regs)
> -{
> -       u32 stat;
> -
> -       stat =3D readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_LOW_OFF);
> -       stat &=3D readl_relaxed(mv78xx0_irq_base + IRQ_MASK_LOW_OFF);
> -       if (stat) {
> -               unsigned int hwirq =3D __fls(stat);
> -               handle_IRQ(hwirq, regs);
> -               return;
> -       }
> -       stat =3D readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_HIGH_OFF);
> -       stat &=3D readl_relaxed(mv78xx0_irq_base + IRQ_MASK_HIGH_OFF);
> -       if (stat) {
> -               unsigned int hwirq =3D 32 + __fls(stat);
> -               handle_IRQ(hwirq, regs);
> -               return;
> -       }
> -       stat =3D readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_ERR_OFF);
> -       stat &=3D readl_relaxed(mv78xx0_irq_base + IRQ_MASK_ERR_OFF);
> -       if (stat) {
> -               unsigned int hwirq =3D 64 + __fls(stat);
> -               handle_IRQ(hwirq, regs);
> -               return;
> -       }
> -}
> -
> -void __init mv78xx0_init_irq(void)
> -{
> -       orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
> -       orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
> -       orion_irq_init(64, IRQ_VIRT_BASE + IRQ_MASK_ERR_OFF);
> -
> -       set_handle_irq(mv78xx0_legacy_handle_irq);
> -
> -       /*
> -        * Initialize gpiolib for GPIOs 0-31.  (The GPIO interrupt mask
> -        * registers for core #1 are at an offset of 0x18 from those of
> -        * core #0.)
> -        */
> -       orion_gpio_init(0, 32, GPIO_VIRT_BASE, mv78xx0_core_index() ? 0x1=
8 : 0,
> -                       IRQ_MV78XX0_GPIO_START, gpio0_irqs);
> -}
> diff --git a/arch/arm/mach-mv78xx0/irqs.h b/arch/arm/mach-mv78xx0/irqs.h
> deleted file mode 100644
> index 12b357d383d8..000000000000
> --- a/arch/arm/mach-mv78xx0/irqs.h
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/* IRQ definitions for Marvell MV78xx0 SoCs */
> -
> -#ifndef __ASM_ARCH_IRQS_H
> -#define __ASM_ARCH_IRQS_H
> -
> -/*
> - * MV78xx0 Low Interrupt Controller
> - */
> -#define IRQ_MV78XX0_ERR                0
> -#define IRQ_MV78XX0_SPI                1
> -#define IRQ_MV78XX0_I2C_0      2
> -#define IRQ_MV78XX0_I2C_1      3
> -#define IRQ_MV78XX0_IDMA_0     4
> -#define IRQ_MV78XX0_IDMA_1     5
> -#define IRQ_MV78XX0_IDMA_2     6
> -#define IRQ_MV78XX0_IDMA_3     7
> -#define IRQ_MV78XX0_TIMER_0    8
> -#define IRQ_MV78XX0_TIMER_1    9
> -#define IRQ_MV78XX0_TIMER_2    10
> -#define IRQ_MV78XX0_TIMER_3    11
> -#define IRQ_MV78XX0_UART_0     12
> -#define IRQ_MV78XX0_UART_1     13
> -#define IRQ_MV78XX0_UART_2     14
> -#define IRQ_MV78XX0_UART_3     15
> -#define IRQ_MV78XX0_USB_0      16
> -#define IRQ_MV78XX0_USB_1      17
> -#define IRQ_MV78XX0_USB_2      18
> -#define IRQ_MV78XX0_CRYPTO     19
> -#define IRQ_MV78XX0_SDIO_0     20
> -#define IRQ_MV78XX0_SDIO_1     21
> -#define IRQ_MV78XX0_XOR_0      22
> -#define IRQ_MV78XX0_XOR_1      23
> -#define IRQ_MV78XX0_I2S_0      24
> -#define IRQ_MV78XX0_I2S_1      25
> -#define IRQ_MV78XX0_SATA       26
> -#define IRQ_MV78XX0_TDMI       27
> -
> -/*
> - * MV78xx0 High Interrupt Controller
> - */
> -#define IRQ_MV78XX0_PCIE_00    32
> -#define IRQ_MV78XX0_PCIE_01    33
> -#define IRQ_MV78XX0_PCIE_02    34
> -#define IRQ_MV78XX0_PCIE_03    35
> -#define IRQ_MV78XX0_PCIE_10    36
> -#define IRQ_MV78XX0_PCIE_11    37
> -#define IRQ_MV78XX0_PCIE_12    38
> -#define IRQ_MV78XX0_PCIE_13    39
> -#define IRQ_MV78XX0_GE00_SUM   40
> -#define IRQ_MV78XX0_GE00_RX    41
> -#define IRQ_MV78XX0_GE00_TX    42
> -#define IRQ_MV78XX0_GE00_MISC  43
> -#define IRQ_MV78XX0_GE01_SUM   44
> -#define IRQ_MV78XX0_GE01_RX    45
> -#define IRQ_MV78XX0_GE01_TX    46
> -#define IRQ_MV78XX0_GE01_MISC  47
> -#define IRQ_MV78XX0_GE10_SUM   48
> -#define IRQ_MV78XX0_GE10_RX    49
> -#define IRQ_MV78XX0_GE10_TX    50
> -#define IRQ_MV78XX0_GE10_MISC  51
> -#define IRQ_MV78XX0_GE11_SUM   52
> -#define IRQ_MV78XX0_GE11_RX    53
> -#define IRQ_MV78XX0_GE11_TX    54
> -#define IRQ_MV78XX0_GE11_MISC  55
> -#define IRQ_MV78XX0_GPIO_0_7   56
> -#define IRQ_MV78XX0_GPIO_8_15  57
> -#define IRQ_MV78XX0_GPIO_16_23 58
> -#define IRQ_MV78XX0_GPIO_24_31 59
> -#define IRQ_MV78XX0_DB_IN      60
> -#define IRQ_MV78XX0_DB_OUT     61
> -
> -/*
> - * MV78xx0 Error Interrupt Controller
> - */
> -#define IRQ_MV78XX0_GE_ERR     70
> -
> -/*
> - * MV78XX0 General Purpose Pins
> - */
> -#define IRQ_MV78XX0_GPIO_START 96
> -#define NR_GPIO_IRQS           32
> -
> -#define MV78XX0_NR_IRQS                (IRQ_MV78XX0_GPIO_START + NR_GPIO=
_IRQS)
> -
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
> deleted file mode 100644
> index 32bf590d79fe..000000000000
> --- a/arch/arm/mach-mv78xx0/mpp.c
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-mv78x00/mpp.c
> - *
> - * MPP functions for Marvell MV78x00 SoCs
> - */
> -#include <linux/gpio/consumer.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <plat/mpp.h>
> -#include "mv78xx0.h"
> -#include "common.h"
> -#include "mpp.h"
> -
> -static unsigned int __init mv78xx0_variant(void)
> -{
> -       u32 dev, rev;
> -
> -       mv78xx0_pcie_id(&dev, &rev);
> -
> -       if (dev =3D=3D MV78100_DEV_ID && rev >=3D MV78100_REV_A0)
> -               return MPP_78100_A0_MASK;
> -
> -       printk(KERN_ERR "MPP setup: unknown mv78x00 variant "
> -                       "(dev %#x rev %#x)\n", dev, rev);
> -       return 0;
> -}
> -
> -void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
> -{
> -       orion_mpp_conf(mpp_list, mv78xx0_variant(),
> -                      MPP_MAX, DEV_BUS_VIRT_BASE);
> -}
> diff --git a/arch/arm/mach-mv78xx0/mpp.h b/arch/arm/mach-mv78xx0/mpp.h
> deleted file mode 100644
> index 47db52f45546..000000000000
> --- a/arch/arm/mach-mv78xx0/mpp.h
> +++ /dev/null
> @@ -1,337 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * linux/arch/arm/mach-mv78xx0/mpp.h -- Multi Purpose Pins
> - *
> - * sebastien requiem <sebastien@requiem.fr>
> - */
> -
> -#ifndef __MV78X00_MPP_H
> -#define __MV78X00_MPP_H
> -
> -#define MPP(_num, _sel, _in, _out, _78100_A0) (\
> -    /* MPP number */        ((_num) & 0xff) | \
> -    /* MPP select value */        (((_sel) & 0xf) << 8) | \
> -    /* may be input signal */    ((!!(_in)) << 12) | \
> -    /* may be output signal */    ((!!(_out)) << 13) | \
> -    /* available on A0 */    ((!!(_78100_A0)) << 14))
> -
> -                /*   num sel  i  o  78100_A0  */
> -
> -#define MPP_78100_A0_MASK    MPP(0, 0x0, 0, 0, 1)
> -
> -#define MPP0_GPIO        MPP(0, 0x0, 1, 1, 1)
> -#define MPP0_GE0_COL        MPP(0, 0x1, 0, 0, 1)
> -#define MPP0_GE1_TXCLK        MPP(0, 0x2, 0, 0, 1)
> -#define MPP0_UNUSED        MPP(0, 0x3, 0, 0, 1)
> -
> -#define MPP1_GPIO        MPP(1, 0x0, 1, 1, 1)
> -#define MPP1_GE0_RXERR        MPP(1, 0x1, 0, 0, 1)
> -#define MPP1_GE1_TXCTL        MPP(1, 0x2, 0, 0, 1)
> -#define MPP1_UNUSED        MPP(1, 0x3, 0, 0, 1)
> -
> -#define MPP2_GPIO        MPP(2, 0x0, 1, 1, 1)
> -#define MPP2_GE0_CRS        MPP(2, 0x1, 0, 0, 1)
> -#define MPP2_GE1_RXCTL        MPP(2, 0x2, 0, 0, 1)
> -#define MPP2_UNUSED        MPP(2, 0x3, 0, 0, 1)
> -
> -#define MPP3_GPIO        MPP(3, 0x0, 1, 1, 1)
> -#define MPP3_GE0_TXERR        MPP(3, 0x1, 0, 0, 1)
> -#define MPP3_GE1_RXCLK        MPP(3, 0x2, 0, 0, 1)
> -#define MPP3_UNUSED        MPP(3, 0x3, 0, 0, 1)
> -
> -#define MPP4_GPIO        MPP(4, 0x0, 1, 1, 1)
> -#define MPP4_GE0_TXD4        MPP(4, 0x1, 0, 0, 1)
> -#define MPP4_GE1_TXD0        MPP(4, 0x2, 0, 0, 1)
> -#define MPP4_UNUSED        MPP(4, 0x3, 0, 0, 1)
> -
> -#define MPP5_GPIO        MPP(5, 0x0, 1, 1, 1)
> -#define MPP5_GE0_TXD5        MPP(5, 0x1, 0, 0, 1)
> -#define MPP5_GE1_TXD1        MPP(5, 0x2, 0, 0, 1)
> -#define MPP5_UNUSED        MPP(5, 0x3, 0, 0, 1)
> -
> -#define MPP6_GPIO        MPP(6, 0x0, 1, 1, 1)
> -#define MPP6_GE0_TXD6        MPP(6, 0x1, 0, 0, 1)
> -#define MPP6_GE1_TXD2        MPP(6, 0x2, 0, 0, 1)
> -#define MPP6_UNUSED        MPP(6, 0x3, 0, 0, 1)
> -
> -#define MPP7_GPIO        MPP(7, 0x0, 1, 1, 1)
> -#define MPP7_GE0_TXD7        MPP(7, 0x1, 0, 0, 1)
> -#define MPP7_GE1_TXD3        MPP(7, 0x2, 0, 0, 1)
> -#define MPP7_UNUSED        MPP(7, 0x3, 0, 0, 1)
> -
> -#define MPP8_GPIO        MPP(8, 0x0, 1, 1, 1)
> -#define MPP8_GE0_RXD4        MPP(8, 0x1, 0, 0, 1)
> -#define MPP8_GE1_RXD0        MPP(8, 0x2, 0, 0, 1)
> -#define MPP8_UNUSED        MPP(8, 0x3, 0, 0, 1)
> -
> -#define MPP9_GPIO        MPP(9, 0x0, 1, 1, 1)
> -#define MPP9_GE0_RXD5        MPP(9, 0x1, 0, 0, 1)
> -#define MPP9_GE1_RXD1        MPP(9, 0x2, 0, 0, 1)
> -#define MPP9_UNUSED        MPP(9, 0x3, 0, 0, 1)
> -
> -#define MPP10_GPIO        MPP(10, 0x0, 1, 1, 1)
> -#define MPP10_GE0_RXD6        MPP(10, 0x1, 0, 0, 1)
> -#define MPP10_GE1_RXD2        MPP(10, 0x2, 0, 0, 1)
> -#define MPP10_UNUSED        MPP(10, 0x3, 0, 0, 1)
> -
> -#define MPP11_GPIO        MPP(11, 0x0, 1, 1, 1)
> -#define MPP11_GE0_RXD7        MPP(11, 0x1, 0, 0, 1)
> -#define MPP11_GE1_RXD3        MPP(11, 0x2, 0, 0, 1)
> -#define MPP11_UNUSED        MPP(11, 0x3, 0, 0, 1)
> -
> -#define MPP12_GPIO        MPP(12, 0x0, 1, 1, 1)
> -#define MPP12_M_BB        MPP(12, 0x3, 0, 0, 1)
> -#define MPP12_UA0_CTSn        MPP(12, 0x4, 0, 0, 1)
> -#define MPP12_NAND_FLASH_REn0    MPP(12, 0x5, 0, 0, 1)
> -#define MPP12_TDM0_SCSn        MPP(12, 0X6, 0, 0, 1)
> -#define MPP12_UNUSED        MPP(12, 0x1, 0, 0, 1)
> -
> -#define MPP13_GPIO        MPP(13, 0x0, 1, 1, 1)
> -#define MPP13_SYSRST_OUTn    MPP(13, 0x3, 0, 0, 1)
> -#define MPP13_UA0_RTSn        MPP(13, 0x4, 0, 0, 1)
> -#define MPP13_NAN_FLASH_WEn0    MPP(13, 0x5, 0, 0, 1)
> -#define MPP13_TDM_SCLK        MPP(13, 0x6, 0, 0, 1)
> -#define MPP13_UNUSED        MPP(13, 0x1, 0, 0, 1)
> -
> -#define MPP14_GPIO        MPP(14, 0x0, 1, 1, 1)
> -#define MPP14_SATA1_ACTn    MPP(14, 0x3, 0, 0, 1)
> -#define MPP14_UA1_CTSn        MPP(14, 0x4, 0, 0, 1)
> -#define MPP14_NAND_FLASH_REn1    MPP(14, 0x5, 0, 0, 1)
> -#define MPP14_TDM_SMOSI        MPP(14, 0x6, 0, 0, 1)
> -#define MPP14_UNUSED        MPP(14, 0x1, 0, 0, 1)
> -
> -#define MPP15_GPIO        MPP(15, 0x0, 1, 1, 1)
> -#define MPP15_SATA0_ACTn    MPP(15, 0x3, 0, 0, 1)
> -#define MPP15_UA1_RTSn        MPP(15, 0x4, 0, 0, 1)
> -#define MPP15_NAND_FLASH_WEn1    MPP(15, 0x5, 0, 0, 1)
> -#define MPP15_TDM_SMISO        MPP(15, 0x6, 0, 0, 1)
> -#define MPP15_UNUSED        MPP(15, 0x1, 0, 0, 1)
> -
> -#define MPP16_GPIO        MPP(16, 0x0, 1, 1, 1)
> -#define MPP16_SATA1_PRESENTn    MPP(16, 0x3, 0, 0, 1)
> -#define MPP16_UA2_TXD        MPP(16, 0x4, 0, 0, 1)
> -#define MPP16_NAND_FLASH_REn3    MPP(16, 0x5, 0, 0, 1)
> -#define MPP16_TDM_INTn        MPP(16, 0x6, 0, 0, 1)
> -#define MPP16_UNUSED        MPP(16, 0x1, 0, 0, 1)
> -
> -
> -#define MPP17_GPIO        MPP(17, 0x0, 1, 1, 1)
> -#define MPP17_SATA0_PRESENTn    MPP(17, 0x3, 0, 0, 1)
> -#define MPP17_UA2_RXD        MPP(17, 0x4, 0, 0, 1)
> -#define MPP17_NAND_FLASH_WEn3    MPP(17, 0x5, 0, 0, 1)
> -#define MPP17_TDM_RSTn        MPP(17, 0x6, 0, 0, 1)
> -#define MPP17_UNUSED        MPP(17, 0x1, 0, 0, 1)
> -
> -
> -#define MPP18_GPIO        MPP(18, 0x0, 1, 1, 1)
> -#define MPP18_UA0_CTSn        MPP(18, 0x4, 0, 0, 1)
> -#define MPP18_BOOT_FLASH_REn    MPP(18, 0x5, 0, 0, 1)
> -#define MPP18_UNUSED        MPP(18, 0x1, 0, 0, 1)
> -
> -
> -
> -#define MPP19_GPIO        MPP(19, 0x0, 1, 1, 1)
> -#define MPP19_UA0_CTSn        MPP(19, 0x4, 0, 0, 1)
> -#define MPP19_BOOT_FLASH_WEn    MPP(19, 0x5, 0, 0, 1)
> -#define MPP19_UNUSED        MPP(19, 0x1, 0, 0, 1)
> -
> -
> -#define MPP20_GPIO        MPP(20, 0x0, 1, 1, 1)
> -#define MPP20_UA1_CTSs        MPP(20, 0x4, 0, 0, 1)
> -#define MPP20_TDM_PCLK        MPP(20, 0x6, 0, 0, 0)
> -#define MPP20_UNUSED        MPP(20, 0x1, 0, 0, 1)
> -
> -
> -
> -#define MPP21_GPIO        MPP(21, 0x0, 1, 1, 1)
> -#define MPP21_UA1_CTSs        MPP(21, 0x4, 0, 0, 1)
> -#define MPP21_TDM_FSYNC        MPP(21, 0x6, 0, 0, 0)
> -#define MPP21_UNUSED        MPP(21, 0x1, 0, 0, 1)
> -
> -
> -
> -#define MPP22_GPIO        MPP(22, 0x0, 1, 1, 1)
> -#define MPP22_UA3_TDX        MPP(22, 0x4, 0, 0, 1)
> -#define MPP22_NAND_FLASH_REn2    MPP(22, 0x5, 0, 0, 1)
> -#define MPP22_TDM_DRX        MPP(22, 0x6, 0, 0, 1)
> -#define MPP22_UNUSED        MPP(22, 0x1, 0, 0, 1)
> -
> -
> -
> -#define MPP23_GPIO        MPP(23, 0x0, 1, 1, 1)
> -#define MPP23_UA3_RDX        MPP(23, 0x4, 0, 0, 1)
> -#define MPP23_NAND_FLASH_WEn2    MPP(23, 0x5, 0, 0, 1)
> -#define MPP23_TDM_DTX        MPP(23, 0x6, 0, 0, 1)
> -#define MPP23_UNUSED        MPP(23, 0x1, 0, 0, 1)
> -
> -
> -#define MPP24_GPIO        MPP(24, 0x0, 1, 1, 1)
> -#define MPP24_UA2_TXD        MPP(24, 0x4, 0, 0, 1)
> -#define MPP24_TDM_INTn        MPP(24, 0x6, 0, 0, 1)
> -#define MPP24_UNUSED        MPP(24, 0x1, 0, 0, 1)
> -
> -
> -#define MPP25_GPIO        MPP(25, 0x0, 1, 1, 1)
> -#define MPP25_UA2_RXD        MPP(25, 0x4, 0, 0, 1)
> -#define MPP25_TDM_RSTn        MPP(25, 0x6, 0, 0, 1)
> -#define MPP25_UNUSED        MPP(25, 0x1, 0, 0, 1)
> -
> -
> -#define MPP26_GPIO        MPP(26, 0x0, 1, 1, 1)
> -#define MPP26_UA2_CTSn        MPP(26, 0x4, 0, 0, 1)
> -#define MPP26_TDM_PCLK        MPP(26, 0x6, 0, 0, 1)
> -#define MPP26_UNUSED        MPP(26, 0x1, 0, 0, 1)
> -
> -
> -#define MPP27_GPIO        MPP(27, 0x0, 1, 1, 1)
> -#define MPP27_UA2_RTSn        MPP(27, 0x4, 0, 0, 1)
> -#define MPP27_TDM_FSYNC        MPP(27, 0x6, 0, 0, 1)
> -#define MPP27_UNUSED        MPP(27, 0x1, 0, 0, 1)
> -
> -
> -#define MPP28_GPIO        MPP(28, 0x0, 1, 1, 1)
> -#define MPP28_UA3_TXD        MPP(28, 0x4, 0, 0, 1)
> -#define MPP28_TDM_DRX        MPP(28, 0x6, 0, 0, 1)
> -#define MPP28_UNUSED        MPP(28, 0x1, 0, 0, 1)
> -
> -#define MPP29_GPIO        MPP(29, 0x0, 1, 1, 1)
> -#define MPP29_UA3_RXD        MPP(29, 0x4, 0, 0, 1)
> -#define MPP29_SYSRST_OUTn    MPP(29, 0x5, 0, 0, 1)
> -#define MPP29_TDM_DTX        MPP(29, 0x6, 0, 0, 1)
> -#define MPP29_UNUSED        MPP(29, 0x1, 0, 0, 1)
> -
> -#define MPP30_GPIO        MPP(30, 0x0, 1, 1, 1)
> -#define MPP30_UA3_CTSn        MPP(30, 0x4, 0, 0, 1)
> -#define MPP30_UNUSED        MPP(30, 0x1, 0, 0, 1)
> -
> -#define MPP31_GPIO        MPP(31, 0x0, 1, 1, 1)
> -#define MPP31_UA3_RTSn        MPP(31, 0x4, 0, 0, 1)
> -#define MPP31_TDM1_SCSn        MPP(31, 0x6, 0, 0, 1)
> -#define MPP31_UNUSED        MPP(31, 0x1, 0, 0, 1)
> -
> -
> -#define MPP32_GPIO        MPP(32, 0x1, 1, 1, 1)
> -#define MPP32_UA3_TDX        MPP(32, 0x4, 0, 0, 1)
> -#define MPP32_SYSRST_OUTn    MPP(32, 0x5, 0, 0, 1)
> -#define MPP32_TDM0_RXQ        MPP(32, 0x6, 0, 0, 1)
> -#define MPP32_UNUSED        MPP(32, 0x3, 0, 0, 1)
> -
> -
> -#define MPP33_GPIO        MPP(33, 0x1, 1, 1, 1)
> -#define MPP33_UA3_RDX        MPP(33, 0x4, 0, 0, 1)
> -#define MPP33_TDM0_TXQ        MPP(33, 0x6, 0, 0, 1)
> -#define MPP33_UNUSED        MPP(33, 0x3, 0, 0, 1)
> -
> -
> -
> -#define MPP34_GPIO        MPP(34, 0x1, 1, 1, 1)
> -#define MPP34_UA2_TDX        MPP(34, 0x4, 0, 0, 1)
> -#define MPP34_TDM1_RXQ        MPP(34, 0x6, 0, 0, 1)
> -#define MPP34_UNUSED        MPP(34, 0x3, 0, 0, 1)
> -
> -
> -
> -#define MPP35_GPIO        MPP(35, 0x1, 1, 1, 1)
> -#define MPP35_UA2_RDX        MPP(35, 0x4, 0, 0, 1)
> -#define MPP35_TDM1_TXQ        MPP(35, 0x6, 0, 0, 1)
> -#define MPP35_UNUSED        MPP(35, 0x3, 0, 0, 1)
> -
> -#define MPP36_GPIO        MPP(36, 0x1, 1, 1, 1)
> -#define MPP36_UA0_CTSn        MPP(36, 0x2, 0, 0, 1)
> -#define MPP36_UA2_TDX        MPP(36, 0x4, 0, 0, 1)
> -#define MPP36_TDM0_SCSn        MPP(36, 0x6, 0, 0, 1)
> -#define MPP36_UNUSED        MPP(36, 0x3, 0, 0, 1)
> -
> -
> -#define MPP37_GPIO        MPP(37, 0x1, 1, 1, 1)
> -#define MPP37_UA0_RTSn        MPP(37, 0x2, 0, 0, 1)
> -#define MPP37_UA2_RXD        MPP(37, 0x4, 0, 0, 1)
> -#define MPP37_SYSRST_OUTn    MPP(37, 0x5, 0, 0, 1)
> -#define MPP37_TDM_SCLK        MPP(37, 0x6, 0, 0, 1)
> -#define MPP37_UNUSED        MPP(37, 0x3, 0, 0, 1)
> -
> -
> -
> -
> -#define MPP38_GPIO        MPP(38, 0x1, 1, 1, 1)
> -#define MPP38_UA1_CTSn        MPP(38, 0x2, 0, 0, 1)
> -#define MPP38_UA3_TXD        MPP(38, 0x4, 0, 0, 1)
> -#define MPP38_SYSRST_OUTn    MPP(38, 0x5, 0, 0, 1)
> -#define MPP38_TDM_SMOSI        MPP(38, 0x6, 0, 0, 1)
> -#define MPP38_UNUSED        MPP(38, 0x3, 0, 0, 1)
> -
> -
> -
> -
> -#define MPP39_GPIO        MPP(39, 0x1, 1, 1, 1)
> -#define MPP39_UA1_RTSn        MPP(39, 0x2, 0, 0, 1)
> -#define MPP39_UA3_RXD        MPP(39, 0x4, 0, 0, 1)
> -#define MPP39_SYSRST_OUTn    MPP(39, 0x5, 0, 0, 1)
> -#define MPP39_TDM_SMISO        MPP(39, 0x6, 0, 0, 1)
> -#define MPP39_UNUSED        MPP(39, 0x3, 0, 0, 1)
> -
> -
> -
> -#define MPP40_GPIO        MPP(40, 0x1, 1, 1, 1)
> -#define MPP40_TDM_INTn        MPP(40, 0x6, 0, 0, 1)
> -#define MPP40_UNUSED        MPP(40, 0x0, 0, 0, 1)
> -
> -
> -
> -#define MPP41_GPIO        MPP(41, 0x1, 1, 1, 1)
> -#define MPP41_TDM_RSTn        MPP(41, 0x6, 0, 0, 1)
> -#define MPP41_UNUSED        MPP(41, 0x0, 0, 0, 1)
> -
> -
> -
> -#define MPP42_GPIO        MPP(42, 0x1, 1, 1, 1)
> -#define MPP42_TDM_PCLK        MPP(42, 0x6, 0, 0, 1)
> -#define MPP42_UNUSED        MPP(42, 0x0, 0, 0, 1)
> -
> -
> -
> -#define MPP43_GPIO        MPP(43, 0x1, 1, 1, 1)
> -#define MPP43_TDM_FSYNC        MPP(43, 0x6, 0, 0, 1)
> -#define MPP43_UNUSED        MPP(43, 0x0, 0, 0, 1)
> -
> -
> -
> -#define MPP44_GPIO        MPP(44, 0x1, 1, 1, 1)
> -#define MPP44_TDM_DRX        MPP(44, 0x6, 0, 0, 1)
> -#define MPP44_UNUSED        MPP(44, 0x0, 0, 0, 1)
> -
> -
> -
> -#define MPP45_GPIO        MPP(45, 0x1, 1, 1, 1)
> -#define MPP45_SATA0_ACTn    MPP(45, 0x3, 0, 0, 1)
> -#define MPP45_TDM_DRX        MPP(45, 0x6, 0, 0, 1)
> -#define MPP45_UNUSED        MPP(45, 0x0, 0, 0, 1)
> -
> -
> -#define MPP46_GPIO        MPP(46, 0x1, 1, 1, 1)
> -#define MPP46_TDM_SCSn        MPP(46, 0x6, 0, 0, 1)
> -#define MPP46_UNUSED        MPP(46, 0x0, 0, 0, 1)
> -
> -
> -#define MPP47_GPIO        MPP(47, 0x1, 1, 1, 1)
> -#define MPP47_UNUSED        MPP(47, 0x0, 0, 0, 1)
> -
> -
> -
> -#define MPP48_GPIO        MPP(48, 0x1, 1, 1, 1)
> -#define MPP48_SATA1_ACTn    MPP(48, 0x3, 0, 0, 1)
> -#define MPP48_UNUSED        MPP(48, 0x2, 0, 0, 1)
> -
> -
> -
> -#define MPP49_GPIO        MPP(49, 0x1, 1, 1, 1)
> -#define MPP49_SATA0_ACTn    MPP(49, 0x3, 0, 0, 1)
> -#define MPP49_M_BB        MPP(49, 0x4, 0, 0, 1)
> -#define MPP49_UNUSED        MPP(49, 0x2, 0, 0, 1)
> -
> -
> -#define MPP_MAX            49
> -
> -void mv78xx0_mpp_conf(unsigned int *mpp_list);
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/mv78xx0.h b/arch/arm/mach-mv78xx0/mv78=
xx0.h
> deleted file mode 100644
> index 88efb1e44142..000000000000
> --- a/arch/arm/mach-mv78xx0/mv78xx0.h
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Generic definitions for Marvell MV78xx0 SoC flavors:
> - *  MV781x0 and MV782x0.
> - */
> -
> -#ifndef __ASM_ARCH_MV78XX0_H
> -#define __ASM_ARCH_MV78XX0_H
> -
> -#include "irqs.h"
> -
> -/*
> - * Marvell MV78xx0 address maps.
> - *
> - * phys
> - * c0000000    PCIe Memory space
> - * f0800000    PCIe #0 I/O space
> - * f0900000    PCIe #1 I/O space
> - * f0a00000    PCIe #2 I/O space
> - * f0b00000    PCIe #3 I/O space
> - * f0c00000    PCIe #4 I/O space
> - * f0d00000    PCIe #5 I/O space
> - * f0e00000    PCIe #6 I/O space
> - * f0f00000    PCIe #7 I/O space
> - * f1000000    on-chip peripheral registers
> - *
> - * virt                phys            size
> - * fe400000    f102x000        16K     core-specific peripheral register=
s
> - * fee00000    f0800000        64K     PCIe #0 I/O space
> - * fee10000    f0900000        64K     PCIe #1 I/O space
> - * fee20000    f0a00000        64K     PCIe #2 I/O space
> - * fee30000    f0b00000        64K     PCIe #3 I/O space
> - * fee40000    f0c00000        64K     PCIe #4 I/O space
> - * fee50000    f0d00000        64K     PCIe #5 I/O space
> - * fee60000    f0e00000        64K     PCIe #6 I/O space
> - * fee70000    f0f00000        64K     PCIe #7 I/O space
> - * fec00000    f1000000        1M      on-chip peripheral registers
> - */
> -#define MV78XX0_CORE0_REGS_PHYS_BASE   0xf1020000
> -#define MV78XX0_CORE1_REGS_PHYS_BASE   0xf1024000
> -#define MV78XX0_CORE_REGS_VIRT_BASE    IOMEM(0xfe400000)
> -#define MV78XX0_CORE_REGS_PHYS_BASE    0xfe400000
> -#define MV78XX0_CORE_REGS_SIZE         SZ_16K
> -
> -#define MV78XX0_PCIE_IO_PHYS_BASE(i)   (0xf0800000 + ((i) << 20))
> -#define MV78XX0_PCIE_IO_SIZE           SZ_1M
> -
> -#define MV78XX0_REGS_PHYS_BASE         0xf1000000
> -#define MV78XX0_REGS_VIRT_BASE         IOMEM(0xfec00000)
> -#define MV78XX0_REGS_SIZE              SZ_1M
> -
> -#define MV78XX0_SRAM_PHYS_BASE          (0xf2200000)
> -#define MV78XX0_SRAM_SIZE               SZ_8K
> -
> -#define MV78XX0_PCIE_MEM_PHYS_BASE     0xc0000000
> -#define MV78XX0_PCIE_MEM_SIZE          0x30000000
> -
> -#define MV78XX0_MBUS_SRAM_TARGET       0x09
> -#define MV78XX0_MBUS_SRAM_ATTR         0x00
> -
> -/*
> - * Core-specific peripheral registers.
> - */
> -#define BRIDGE_VIRT_BASE       (MV78XX0_CORE_REGS_VIRT_BASE)
> -#define BRIDGE_PHYS_BASE       (MV78XX0_CORE_REGS_PHYS_BASE)
> -#define  BRIDGE_WINS_CPU0_BASE  (MV78XX0_CORE0_REGS_PHYS_BASE)
> -#define  BRIDGE_WINS_CPU1_BASE  (MV78XX0_CORE1_REGS_PHYS_BASE)
> -#define  BRIDGE_WINS_SZ         (0xA000)
> -
> -/*
> - * Register Map
> - */
> -#define DDR_VIRT_BASE          (MV78XX0_REGS_VIRT_BASE + 0x00000)
> -#define DDR_PHYS_BASE           (MV78XX0_REGS_PHYS_BASE + 0x00000)
> -#define  DDR_WINDOW_CPU0_BASE  (DDR_PHYS_BASE + 0x1500)
> -#define  DDR_WINDOW_CPU1_BASE  (DDR_PHYS_BASE + 0x1570)
> -#define  DDR_WINDOW_CPU_SZ      (0x20)
> -
> -#define DEV_BUS_PHYS_BASE      (MV78XX0_REGS_PHYS_BASE + 0x10000)
> -#define DEV_BUS_VIRT_BASE      (MV78XX0_REGS_VIRT_BASE + 0x10000)
> -#define  SAMPLE_AT_RESET_LOW   (DEV_BUS_VIRT_BASE + 0x0030)
> -#define  SAMPLE_AT_RESET_HIGH  (DEV_BUS_VIRT_BASE + 0x0034)
> -#define  GPIO_VIRT_BASE                (DEV_BUS_VIRT_BASE + 0x0100)
> -#define  I2C_0_PHYS_BASE       (DEV_BUS_PHYS_BASE + 0x1000)
> -#define  I2C_1_PHYS_BASE       (DEV_BUS_PHYS_BASE + 0x1100)
> -#define  UART0_PHYS_BASE       (DEV_BUS_PHYS_BASE + 0x2000)
> -#define  UART0_VIRT_BASE       (DEV_BUS_VIRT_BASE + 0x2000)
> -#define  UART1_PHYS_BASE       (DEV_BUS_PHYS_BASE + 0x2100)
> -#define  UART1_VIRT_BASE       (DEV_BUS_VIRT_BASE + 0x2100)
> -#define  UART2_PHYS_BASE       (DEV_BUS_PHYS_BASE + 0x2200)
> -#define  UART2_VIRT_BASE       (DEV_BUS_VIRT_BASE + 0x2200)
> -#define  UART3_PHYS_BASE       (DEV_BUS_PHYS_BASE + 0x2300)
> -#define  UART3_VIRT_BASE       (DEV_BUS_VIRT_BASE + 0x2300)
> -
> -#define GE10_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x30000)
> -#define GE11_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x34000)
> -
> -#define PCIE00_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x40000)
> -#define PCIE01_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x44000)
> -#define PCIE02_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x48000)
> -#define PCIE03_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x4c000)
> -
> -#define USB0_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x50000)
> -#define USB1_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x51000)
> -#define USB2_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x52000)
> -
> -#define XOR_PHYS_BASE          (MV78XX0_REGS_PHYS_BASE + 0x60900)
> -
> -#define GE00_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x70000)
> -#define GE01_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0x74000)
> -
> -#define PCIE10_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x80000)
> -#define PCIE11_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x84000)
> -#define PCIE12_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x88000)
> -#define PCIE13_VIRT_BASE       (MV78XX0_REGS_VIRT_BASE + 0x8c000)
> -
> -#define CRYPTO_PHYS_BASE       (MV78XX0_REGS_PHYS_BASE + 0x90000)
> -
> -#define SATA_PHYS_BASE         (MV78XX0_REGS_PHYS_BASE + 0xa0000)
> -
> -/*
> - * Supported devices and revisions.
> - */
> -#define MV78X00_Z0_DEV_ID      0x6381
> -#define MV78X00_REV_Z0         1
> -
> -#define MV78100_DEV_ID         0x7810
> -#define MV78100_REV_A0         1
> -#define MV78100_REV_A1         2
> -
> -#define MV78200_DEV_ID         0x7820
> -#define MV78200_REV_A0         1
> -
> -#endif
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> deleted file mode 100644
> index 533cb7856943..000000000000
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ /dev/null
> @@ -1,280 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-mv78xx0/pcie.c
> - *
> - * PCIe functions for Marvell MV78xx0 SoCs
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/pci.h>
> -#include <linux/mbus.h>
> -#include <video/vga.h>
> -#include <asm/irq.h>
> -#include <asm/mach/pci.h>
> -#include <plat/pcie.h>
> -#include "mv78xx0.h"
> -#include "common.h"
> -
> -#define MV78XX0_MBUS_PCIE_MEM_TARGET(port, lane) ((port) ? 8 : 4)
> -#define MV78XX0_MBUS_PCIE_MEM_ATTR(port, lane)   (0xf8 & ~(0x10 << (lane=
)))
> -#define MV78XX0_MBUS_PCIE_IO_TARGET(port, lane)  ((port) ? 8 : 4)
> -#define MV78XX0_MBUS_PCIE_IO_ATTR(port, lane)    (0xf0 & ~(0x10 << (lane=
)))
> -
> -struct pcie_port {
> -       u8                      maj;
> -       u8                      min;
> -       u8                      root_bus_nr;
> -       void __iomem            *base;
> -       spinlock_t              conf_lock;
> -       char                    mem_space_name[20];
> -       struct resource         res;
> -};
> -
> -static struct pcie_port pcie_port[8];
> -static int num_pcie_ports;
> -static struct resource pcie_io_space;
> -
> -void __init mv78xx0_pcie_id(u32 *dev, u32 *rev)
> -{
> -       *dev =3D orion_pcie_dev_id(PCIE00_VIRT_BASE);
> -       *rev =3D orion_pcie_rev(PCIE00_VIRT_BASE);
> -}
> -
> -u32 pcie_port_size[8] =3D {
> -       0,
> -       0x20000000,
> -       0x10000000,
> -       0x10000000,
> -       0x08000000,
> -       0x08000000,
> -       0x08000000,
> -       0x04000000,
> -};
> -
> -static void __init mv78xx0_pcie_preinit(void)
> -{
> -       int i;
> -       u32 size_each;
> -       u32 start;
> -
> -       pcie_io_space.name =3D "PCIe I/O Space";
> -       pcie_io_space.start =3D MV78XX0_PCIE_IO_PHYS_BASE(0);
> -       pcie_io_space.end =3D
> -               MV78XX0_PCIE_IO_PHYS_BASE(0) + MV78XX0_PCIE_IO_SIZE * 8 -=
 1;
> -       pcie_io_space.flags =3D IORESOURCE_MEM;
> -       if (request_resource(&iomem_resource, &pcie_io_space))
> -               panic("can't allocate PCIe I/O space");
> -
> -       if (num_pcie_ports > 7)
> -               panic("invalid number of PCIe ports");
> -
> -       size_each =3D pcie_port_size[num_pcie_ports];
> -
> -       start =3D MV78XX0_PCIE_MEM_PHYS_BASE;
> -       for (i =3D 0; i < num_pcie_ports; i++) {
> -               struct pcie_port *pp =3D pcie_port + i;
> -
> -               snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
> -                       "PCIe %d.%d MEM", pp->maj, pp->min);
> -               pp->mem_space_name[sizeof(pp->mem_space_name) - 1] =3D 0;
> -               pp->res.name =3D pp->mem_space_name;
> -               pp->res.flags =3D IORESOURCE_MEM;
> -               pp->res.start =3D start;
> -               pp->res.end =3D start + size_each - 1;
> -               start +=3D size_each;
> -
> -               if (request_resource(&iomem_resource, &pp->res))
> -                       panic("can't allocate PCIe MEM sub-space");
> -
> -               mvebu_mbus_add_window_by_id(MV78XX0_MBUS_PCIE_MEM_TARGET(=
pp->maj, pp->min),
> -                                           MV78XX0_MBUS_PCIE_MEM_ATTR(pp=
->maj, pp->min),
> -                                           pp->res.start, resource_size(=
&pp->res));
> -               mvebu_mbus_add_window_remap_by_id(MV78XX0_MBUS_PCIE_IO_TA=
RGET(pp->maj, pp->min),
> -                                                 MV78XX0_MBUS_PCIE_IO_AT=
TR(pp->maj, pp->min),
> -                                                 i * SZ_64K, SZ_64K, 0);
> -       }
> -}
> -
> -static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
> -{
> -       struct pcie_port *pp;
> -       struct resource realio;
> -
> -       if (nr >=3D num_pcie_ports)
> -               return 0;
> -
> -       pp =3D &pcie_port[nr];
> -       sys->private_data =3D pp;
> -       pp->root_bus_nr =3D sys->busnr;
> -
> -       /*
> -        * Generic PCIe unit setup.
> -        */
> -       orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
> -       orion_pcie_setup(pp->base);
> -
> -       realio.start =3D nr * SZ_64K;
> -       realio.end =3D realio.start + SZ_64K - 1;
> -       pci_remap_iospace(&realio, MV78XX0_PCIE_IO_PHYS_BASE(nr));
> -
> -       pci_add_resource_offset(&sys->resources, &pp->res, sys->mem_offse=
t);
> -
> -       return 1;
> -}
> -
> -static int pcie_valid_config(struct pcie_port *pp, int bus, int dev)
> -{
> -       /*
> -        * Don't go out when trying to access nonexisting devices
> -        * on the local bus.
> -        */
> -       if (bus =3D=3D pp->root_bus_nr && dev > 1)
> -               return 0;
> -
> -       return 1;
> -}
> -
> -static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> -                       int size, u32 *val)
> -{
> -       struct pci_sys_data *sys =3D bus->sysdata;
> -       struct pcie_port *pp =3D sys->private_data;
> -       unsigned long flags;
> -       int ret;
> -
> -       if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) =3D=3D 0)=
 {
> -               *val =3D 0xffffffff;
> -               return PCIBIOS_DEVICE_NOT_FOUND;
> -       }
> -
> -       spin_lock_irqsave(&pp->conf_lock, flags);
> -       ret =3D orion_pcie_rd_conf(pp->base, bus, devfn, where, size, val=
);
> -       spin_unlock_irqrestore(&pp->conf_lock, flags);
> -
> -       return ret;
> -}
> -
> -static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> -                       int where, int size, u32 val)
> -{
> -       struct pci_sys_data *sys =3D bus->sysdata;
> -       struct pcie_port *pp =3D sys->private_data;
> -       unsigned long flags;
> -       int ret;
> -
> -       if (pcie_valid_config(pp, bus->number, PCI_SLOT(devfn)) =3D=3D 0)
> -               return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -       spin_lock_irqsave(&pp->conf_lock, flags);
> -       ret =3D orion_pcie_wr_conf(pp->base, bus, devfn, where, size, val=
);
> -       spin_unlock_irqrestore(&pp->conf_lock, flags);
> -
> -       return ret;
> -}
> -
> -static struct pci_ops pcie_ops =3D {
> -       .read =3D pcie_rd_conf,
> -       .write =3D pcie_wr_conf,
> -};
> -
> -/*
> - * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, whe=
n it
> - * is operating as a root complex this needs to be switched to
> - * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's=
 on
> - * the device. Decoding setup is handled by the orion code.
> - */
> -static void rc_pci_fixup(struct pci_dev *dev)
> -{
> -       if (dev->bus->parent =3D=3D NULL && dev->devfn =3D=3D 0) {
> -               struct resource *r;
> -
> -               dev->class &=3D 0xff;
> -               dev->class |=3D PCI_CLASS_BRIDGE_HOST << 8;
> -               pci_dev_for_each_resource(dev, r) {
> -                       r->start =3D 0;
> -                       r->end   =3D 0;
> -                       r->flags =3D 0;
> -               }
> -       }
> -}
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup=
);
> -
> -static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *=
bridge)
> -{
> -       struct pci_sys_data *sys =3D pci_host_bridge_priv(bridge);
> -
> -       if (nr >=3D num_pcie_ports) {
> -               BUG();
> -               return -EINVAL;
> -       }
> -
> -       list_splice_init(&sys->resources, &bridge->windows);
> -       bridge->dev.parent =3D NULL;
> -       bridge->sysdata =3D sys;
> -       bridge->busnr =3D sys->busnr;
> -       bridge->ops =3D &pcie_ops;
> -
> -       return pci_scan_root_bus_bridge(bridge);
> -}
> -
> -static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slo=
t,
> -       u8 pin)
> -{
> -       struct pci_sys_data *sys =3D dev->bus->sysdata;
> -       struct pcie_port *pp =3D sys->private_data;
> -
> -       return IRQ_MV78XX0_PCIE_00 + (pp->maj << 2) + pp->min;
> -}
> -
> -static struct hw_pci mv78xx0_pci __initdata =3D {
> -       .nr_controllers =3D 8,
> -       .preinit        =3D mv78xx0_pcie_preinit,
> -       .setup          =3D mv78xx0_pcie_setup,
> -       .scan           =3D mv78xx0_pcie_scan_bus,
> -       .map_irq        =3D mv78xx0_pcie_map_irq,
> -};
> -
> -static void __init add_pcie_port(int maj, int min, void __iomem *base)
> -{
> -       printk(KERN_INFO "MV78xx0 PCIe port %d.%d: ", maj, min);
> -
> -       if (orion_pcie_link_up(base)) {
> -               struct pcie_port *pp =3D &pcie_port[num_pcie_ports++];
> -
> -               printk("link up\n");
> -
> -               pp->maj =3D maj;
> -               pp->min =3D min;
> -               pp->root_bus_nr =3D -1;
> -               pp->base =3D base;
> -               spin_lock_init(&pp->conf_lock);
> -               memset(&pp->res, 0, sizeof(pp->res));
> -       } else {
> -               printk("link down, ignoring\n");
> -       }
> -}
> -
> -void __init mv78xx0_pcie_init(int init_port0, int init_port1)
> -{
> -       vga_base =3D MV78XX0_PCIE_MEM_PHYS_BASE;
> -
> -       if (init_port0) {
> -               add_pcie_port(0, 0, PCIE00_VIRT_BASE);
> -               if (!orion_pcie_x4_mode(PCIE00_VIRT_BASE)) {
> -                       add_pcie_port(0, 1, PCIE01_VIRT_BASE);
> -                       add_pcie_port(0, 2, PCIE02_VIRT_BASE);
> -                       add_pcie_port(0, 3, PCIE03_VIRT_BASE);
> -               }
> -       }
> -
> -       if (init_port1) {
> -               add_pcie_port(1, 0, PCIE10_VIRT_BASE);
> -               if (!orion_pcie_x4_mode((void __iomem *)PCIE10_VIRT_BASE)=
) {
> -                       add_pcie_port(1, 1, PCIE11_VIRT_BASE);
> -                       add_pcie_port(1, 2, PCIE12_VIRT_BASE);
> -                       add_pcie_port(1, 3, PCIE13_VIRT_BASE);
> -               }
> -       }
> -
> -       pci_common_init(&mv78xx0_pci);
> -}
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfi=
g
> index c61999d01c80..78b8d59d7cc1 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -37,60 +37,6 @@ config MACH_RD88F5182_DT
>           Say 'Y' here if you want your kernel to support the Marvell
>           Orion-NAS (88F5182) RD2, Flattened Device Tree.
>
> -config MACH_KUROBOX_PRO
> -       bool "KuroBox Pro (DEPRECATED)"
> -       select I2C_BOARDINFO if I2C
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         KuroBox Pro platform.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
> -config MACH_DNS323
> -       bool "D-Link DNS-323 (DEPRECATED)"
> -       select I2C_BOARDINFO if I2C
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         D-Link DNS-323 platform.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
> -config MACH_TS209
> -       bool "QNAP TS-109/TS-209 (DEPRECATED)"
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         QNAP TS-109/TS-209 platform.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
> -config MACH_TERASTATION_PRO2
> -       bool "Buffalo Terastation Pro II/Live (DEPRECATED)"
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         Buffalo Terastation Pro II/Live platform.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
> -config MACH_LINKSTATION_PRO
> -       bool "Buffalo Linkstation Pro/Live (DEPRECATED)"
> -       depends on ATAGS
> -       select I2C_BOARDINFO if I2C
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         Buffalo Linkstation Pro/Live platform. Both v1 and
> -         v2 devices are supported.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
>  config MACH_LINKSTATION_MINI
>         bool "Buffalo Linkstation Mini (Flattened Device Tree)"
>         select ARCH_ORION5X_DT
> @@ -98,36 +44,6 @@ config MACH_LINKSTATION_MINI
>           Say 'Y' here if you want your kernel to support the
>           Buffalo Linkstation Mini (LS-WSGL) platform.
>
> -config MACH_TS409
> -       bool "QNAP TS-409 (DEPRECATED)"
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         QNAP TS-409 platform.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
> -config MACH_TS78XX
> -       bool "Technologic Systems TS-78xx (DEPRECATED)"
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         Technologic Systems TS-78xx platform.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
> -config MACH_MV2120
> -       bool "HP Media Vault mv2120 (DEPRECATED)"
> -       depends on ATAGS
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         HP Media Vault mv2120 or mv5100.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
>  config MACH_D2NET_DT
>         bool "LaCie d2 Network / Big Disk Network (Flattened Device Tree)=
"
>         select ARCH_ORION5X_DT
> @@ -135,17 +51,6 @@ config MACH_D2NET_DT
>           Say 'Y' here if you want your kernel to support the
>           LaCie d2 Network NAS.
>
> -config MACH_NET2BIG
> -       bool "LaCie 2Big Network (DEPRECATED)"
> -       depends on ATAGS
> -       select I2C_BOARDINFO if I2C
> -       help
> -         Say 'Y' here if you want your kernel to support the
> -         LaCie 2Big Network NAS.
> -
> -         Support for this machine will go away in early 2027,
> -         unless it gets converted to device tree.
> -
>  config MACH_MSS2_DT
>         bool "Maxtor Shared Storage II (Flattened Device Tree)"
>         select ARCH_ORION5X_DT
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makef=
ile
> index 6f54d7fef27a..7e9634e04318 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -2,15 +2,6 @@
>  ccflags-y :=3D -I$(srctree)/arch/arm/plat-orion/include
>
>  obj-y                          +=3D common.o pci.o irq.o mpp.o
> -obj-$(CONFIG_MACH_KUROBOX_PRO) +=3D kurobox_pro-setup.o
> -obj-$(CONFIG_MACH_TERASTATION_PRO2)    +=3D terastation_pro2-setup.o
> -obj-$(CONFIG_MACH_LINKSTATION_PRO) +=3D kurobox_pro-setup.o
> -obj-$(CONFIG_MACH_DNS323)      +=3D dns323-setup.o
> -obj-$(CONFIG_MACH_TS209)       +=3D ts209-setup.o tsx09-common.o
> -obj-$(CONFIG_MACH_TS409)       +=3D ts409-setup.o tsx09-common.o
> -obj-$(CONFIG_MACH_TS78XX)      +=3D ts78xx-setup.o
> -obj-$(CONFIG_MACH_MV2120)      +=3D mv2120-setup.o
> -obj-$(CONFIG_MACH_NET2BIG)     +=3D net2big-setup.o
>
>  obj-$(CONFIG_ARCH_ORION5X_DT)          +=3D board-dt.o
>  obj-$(CONFIG_MACH_D2NET_DT)    +=3D board-d2net.o
> diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/boa=
rd-dt.c
> index be47492c6640..2614213e2cbc 100644
> --- a/arch/arm/mach-orion5x/board-dt.c
> +++ b/arch/arm/mach-orion5x/board-dt.c
> @@ -18,7 +18,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <plat/irq.h>
> -#include <plat/time.h>
>  #include "orion5x.h"
>  #include "bridge-regs.h"
>  #include "common.h"
> @@ -39,7 +38,7 @@ static void __init orion5x_dt_init(void)
>         u32 dev, rev;
>
>         orion5x_id(&dev, &rev, &dev_name);
> -       printk(KERN_INFO "Orion ID: %s. TCLK=3D%d.\n", dev_name, orion5x_=
tclk);
> +       printk(KERN_INFO "Orion ID: %s.\n", dev_name);
>
>         BUG_ON(mvebu_mbus_dt_init(false));
>
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/commo=
n.c
> index df056d60b675..050a95af2bbf 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -7,27 +7,16 @@
>   * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
>   */
>
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/platform_device.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/serial_8250.h>
> -#include <linux/mv643xx_i2c.h>
> -#include <linux/ata_platform.h>
> -#include <linux/delay.h>
> -#include <linux/clk-provider.h>
> -#include <linux/cpu.h>
> +#include <linux/mbus.h>
>  #include <asm/page.h>
>  #include <asm/setup.h>
> -#include <asm/system_misc.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> -#include <linux/platform_data/mtd-orion_nand.h>
> -#include <linux/platform_data/usb-ehci-orion.h>
> -#include <plat/time.h>
> -#include <plat/common.h>
>
>  #include "bridge-regs.h"
>  #include "common.h"
> @@ -55,167 +44,6 @@ void __init orion5x_map_io(void)
>         iotable_init(orion5x_io_desc, ARRAY_SIZE(orion5x_io_desc));
>  }
>
> -
> -/***********************************************************************=
******
> - * CLK tree
> - ***********************************************************************=
*****/
> -static struct clk *tclk;
> -
> -void __init clk_init(void)
> -{
> -       tclk =3D clk_register_fixed_rate(NULL, "tclk", NULL, 0, orion5x_t=
clk);
> -
> -       orion_clkdev_init(tclk);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI0
> - ***********************************************************************=
*****/
> -void __init orion5x_ehci0_init(void)
> -{
> -       orion_ehci_init(ORION5X_USB0_PHYS_BASE, IRQ_ORION5X_USB0_CTRL,
> -                       EHCI_PHY_ORION);
> -}
> -
> -
> -/***********************************************************************=
******
> - * EHCI1
> - ***********************************************************************=
*****/
> -void __init orion5x_ehci1_init(void)
> -{
> -       orion_ehci_1_init(ORION5X_USB1_PHYS_BASE, IRQ_ORION5X_USB1_CTRL);
> -}
> -
> -
> -/***********************************************************************=
******
> - * GE00
> - ***********************************************************************=
*****/
> -void __init orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data)
> -{
> -       orion_ge00_init(eth_data,
> -                       ORION5X_ETH_PHYS_BASE, IRQ_ORION5X_ETH_SUM,
> -                       IRQ_ORION5X_ETH_ERR,
> -                       MV643XX_TX_CSUM_DEFAULT_LIMIT);
> -}
> -
> -
> -/***********************************************************************=
******
> - * I2C
> - ***********************************************************************=
*****/
> -void __init orion5x_i2c_init(void)
> -{
> -       orion_i2c_init(I2C_PHYS_BASE, IRQ_ORION5X_I2C, 8);
> -
> -}
> -
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -void __init orion5x_sata_init(struct mv_sata_platform_data *sata_data)
> -{
> -       orion_sata_init(sata_data, ORION5X_SATA_PHYS_BASE, IRQ_ORION5X_SA=
TA);
> -}
> -
> -
> -/***********************************************************************=
******
> - * SPI
> - ***********************************************************************=
*****/
> -void __init orion5x_spi_init(void)
> -{
> -       orion_spi_init(SPI_PHYS_BASE);
> -}
> -
> -
> -/***********************************************************************=
******
> - * UART0
> - ***********************************************************************=
*****/
> -void __init orion5x_uart0_init(void)
> -{
> -       orion_uart0_init(UART0_VIRT_BASE, UART0_PHYS_BASE,
> -                        IRQ_ORION5X_UART0, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * UART1
> - ***********************************************************************=
*****/
> -void __init orion5x_uart1_init(void)
> -{
> -       orion_uart1_init(UART1_VIRT_BASE, UART1_PHYS_BASE,
> -                        IRQ_ORION5X_UART1, tclk);
> -}
> -
> -/***********************************************************************=
******
> - * XOR engine
> - ***********************************************************************=
*****/
> -void __init orion5x_xor_init(void)
> -{
> -       orion_xor0_init(ORION5X_XOR_PHYS_BASE,
> -                       ORION5X_XOR_PHYS_BASE + 0x200,
> -                       IRQ_ORION5X_XOR0, IRQ_ORION5X_XOR1);
> -}
> -
> -/***********************************************************************=
******
> - * Cryptographic Engines and Security Accelerator (CESA)
> - ***********************************************************************=
*****/
> -static void __init orion5x_crypto_init(void)
> -{
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_SRAM_TARGET,
> -                                   ORION_MBUS_SRAM_ATTR,
> -                                   ORION5X_SRAM_PHYS_BASE,
> -                                   ORION5X_SRAM_SIZE);
> -       orion_crypto_init(ORION5X_CRYPTO_PHYS_BASE, ORION5X_SRAM_PHYS_BAS=
E,
> -                         SZ_8K, IRQ_ORION5X_CESA);
> -}
> -
> -/***********************************************************************=
******
> - * Watchdog
> - ***********************************************************************=
*****/
> -static struct resource orion_wdt_resource[] =3D {
> -               DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
> -               DEFINE_RES_MEM(RSTOUTn_MASK_PHYS, 0x04),
> -};
> -
> -static struct platform_device orion_wdt_device =3D {
> -       .name           =3D "orion_wdt",
> -       .id             =3D -1,
> -       .num_resources  =3D ARRAY_SIZE(orion_wdt_resource),
> -       .resource       =3D orion_wdt_resource,
> -};
> -
> -static void __init orion5x_wdt_init(void)
> -{
> -       platform_device_register(&orion_wdt_device);
> -}
> -
> -
> -/***********************************************************************=
******
> - * Time handling
> - ***********************************************************************=
*****/
> -void __init orion5x_init_early(void)
> -{
> -       u32 rev, dev;
> -       const char *mbus_soc_name;
> -
> -       orion_time_set_base(TIMER_VIRT_BASE);
> -
> -       /* Initialize the MBUS driver */
> -       orion5x_pcie_id(&dev, &rev);
> -       if (dev =3D=3D MV88F5281_DEV_ID)
> -               mbus_soc_name =3D "marvell,orion5x-88f5281-mbus";
> -       else if (dev =3D=3D MV88F5182_DEV_ID)
> -               mbus_soc_name =3D "marvell,orion5x-88f5182-mbus";
> -       else if (dev =3D=3D MV88F5181_DEV_ID)
> -               mbus_soc_name =3D "marvell,orion5x-88f5181-mbus";
> -       else if (dev =3D=3D MV88F6183_DEV_ID)
> -               mbus_soc_name =3D "marvell,orion5x-88f6183-mbus";
> -       else
> -               mbus_soc_name =3D NULL;
> -       mvebu_mbus_init(mbus_soc_name, ORION5X_BRIDGE_WINS_BASE,
> -                       ORION5X_BRIDGE_WINS_SZ,
> -                       ORION5X_DDR_WINS_BASE, ORION5X_DDR_WINS_SZ);
> -}
> -
>  void orion5x_setup_wins(void)
>  {
>         /*
> @@ -242,29 +70,6 @@ void orion5x_setup_wins(void)
>                                     ORION5X_PCI_MEM_SIZE);
>  }
>
> -int orion5x_tclk;
> -
> -static int __init orion5x_find_tclk(void)
> -{
> -       u32 dev, rev;
> -
> -       orion5x_pcie_id(&dev, &rev);
> -       if (dev =3D=3D MV88F6183_DEV_ID &&
> -           (readl(MPP_RESET_SAMPLE) & 0x00000200) =3D=3D 0)
> -               return 133333333;
> -
> -       return 166666667;
> -}
> -
> -void __init orion5x_timer_init(void)
> -{
> -       orion5x_tclk =3D orion5x_find_tclk();
> -
> -       orion_time_init(ORION5X_BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
> -                       IRQ_ORION5X_BRIDGE, orion5x_tclk);
> -}
> -
> -
>  /***********************************************************************=
******
>   * General
>   ***********************************************************************=
*****/
> @@ -310,45 +115,6 @@ void __init orion5x_id(u32 *dev, u32 *rev, char **de=
v_name)
>         }
>  }
>
> -void __init orion5x_init(void)
> -{
> -       char *dev_name;
> -       u32 dev, rev;
> -
> -       orion5x_id(&dev, &rev, &dev_name);
> -       printk(KERN_INFO "Orion ID: %s. TCLK=3D%d.\n", dev_name, orion5x_=
tclk);
> -
> -       /*
> -        * Setup Orion address map
> -        */
> -       orion5x_setup_wins();
> -
> -       /* Setup root of clk tree */
> -       clk_init();
> -
> -       /*
> -        * Don't issue "Wait for Interrupt" instruction if we are
> -        * running on D0 5281 silicon.
> -        */
> -       if (dev =3D=3D MV88F5281_DEV_ID && rev =3D=3D MV88F5281_REV_D0) {
> -               printk(KERN_INFO "Orion: Applying 5281 D0 WFI workaround.=
\n");
> -               cpu_idle_poll_ctrl(true);
> -       }
> -
> -       /*
> -        * The 5082/5181l/5182/6082/6082l/6183 have crypto
> -        * while 5180n/5181/5281 don't have crypto.
> -        */
> -       if ((dev =3D=3D MV88F5181_DEV_ID && rev >=3D MV88F5181L_REV_A0) |=
|
> -           dev =3D=3D MV88F5182_DEV_ID || dev =3D=3D MV88F6183_DEV_ID)
> -               orion5x_crypto_init();
> -
> -       /*
> -        * Register watchdog driver
> -        */
> -       orion5x_wdt_init();
> -}
> -
>  void orion5x_restart(enum reboot_mode mode, const char *cmd)
>  {
>         /*
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/commo=
n.h
> index 8df70e23aa82..4dc6c59bde99 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -4,9 +4,6 @@
>
>  #include <linux/reboot.h>
>
> -struct mv643xx_eth_platform_data;
> -struct mv_sata_platform_data;
> -
>  #define ORION_MBUS_PCIE_MEM_TARGET    0x04
>  #define ORION_MBUS_PCIE_MEM_ATTR      0x59
>  #define ORION_MBUS_PCIE_IO_TARGET     0x04
> @@ -32,21 +29,9 @@ void orion5x_init_early(void);
>  void orion5x_init_irq(void);
>  void orion5x_init(void);
>  void orion5x_id(u32 *dev, u32 *rev, char **dev_name);
> -void clk_init(void);
> -extern int orion5x_tclk;
> -extern void orion5x_timer_init(void);
>
>  void orion5x_setup_wins(void);
>
> -void orion5x_ehci0_init(void);
> -void orion5x_ehci1_init(void);
> -void orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data);
> -void orion5x_i2c_init(void);
> -void orion5x_sata_init(struct mv_sata_platform_data *sata_data);
> -void orion5x_spi_init(void);
> -void orion5x_uart0_init(void);
> -void orion5x_uart1_init(void);
> -void orion5x_xor_init(void);
>  void orion5x_restart(enum reboot_mode, const char *);
>
>  /*
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x=
/dns323-setup.c
> deleted file mode 100644
> index 7b81b08b0dda..000000000000
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ /dev/null
> @@ -1,757 +0,0 @@
> -/*
> - * arch/arm/mach-orion5x/dns323-setup.c
> - *
> - * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> - *
> - * Support for HW Rev C1:
> - *
> - * Copyright (C) 2010 Benjamin Herrenschmidt <benh@kernel.crashing.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU Lesser General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - */
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/delay.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/ata_platform.h>
> -#include <linux/phy.h>
> -#include <linux/marvell_phy.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include <asm/system_info.h>
> -#include <plat/orion-gpio.h>
> -#include "orion5x.h"
> -#include "common.h"
> -#include "mpp.h"
> -
> -/* Rev A1 and B1 */
> -#define DNS323_GPIO_LED_RIGHT_AMBER    1
> -#define DNS323_GPIO_LED_LEFT_AMBER     2
> -#define DNS323_GPIO_SYSTEM_UP          3
> -#define DNS323_GPIO_LED_POWER1         4
> -#define DNS323_GPIO_LED_POWER2         5
> -#define DNS323_GPIO_OVERTEMP           6
> -#define DNS323_GPIO_RTC                        7
> -#define DNS323_GPIO_POWER_OFF          8
> -#define DNS323_GPIO_KEY_POWER          9
> -#define DNS323_GPIO_KEY_RESET          10
> -
> -/* Rev C1 */
> -#define DNS323C_GPIO_KEY_POWER         1
> -#define DNS323C_GPIO_POWER_OFF         2
> -#define DNS323C_GPIO_LED_RIGHT_AMBER   8
> -#define DNS323C_GPIO_LED_LEFT_AMBER    9
> -#define DNS323C_GPIO_LED_POWER         17
> -#define DNS323C_GPIO_FAN_BIT1          18
> -#define DNS323C_GPIO_FAN_BIT0          19
> -
> -/* Exposed to userspace, do not change */
> -enum {
> -       DNS323_REV_A1,  /* 0 */
> -       DNS323_REV_B1,  /* 1 */
> -       DNS323_REV_C1,  /* 2 */
> -};
> -
> -
> -/***********************************************************************=
*****
> - * PCI setup
> - */
> -
> -static int __init dns323_pci_map_irq(const struct pci_dev *dev, u8 slot,=
 u8 pin)
> -{
> -       int irq;
> -
> -       /*
> -        * Check for devices with hard-wired IRQs.
> -        */
> -       irq =3D orion5x_pci_map_irq(dev, slot, pin);
> -       if (irq !=3D -1)
> -               return irq;
> -
> -       return -1;
> -}
> -
> -static struct hw_pci dns323_pci __initdata =3D {
> -       .nr_controllers =3D 2,
> -       .setup          =3D orion5x_pci_sys_setup,
> -       .scan           =3D orion5x_pci_sys_scan_bus,
> -       .map_irq        =3D dns323_pci_map_irq,
> -};
> -
> -static int __init dns323_pci_init(void)
> -{
> -       /* Rev B1 and C1 doesn't really use its PCI bus, and initialising=
 PCI
> -        * gets in the way of initialising the SATA controller.
> -        */
> -       if (machine_is_dns323() && system_rev =3D=3D DNS323_REV_A1)
> -               pci_common_init(&dns323_pci);
> -
> -       return 0;
> -}
> -
> -subsys_initcall(dns323_pci_init);
> -
> -/***********************************************************************=
*****
> - * 8MiB NOR flash (Spansion S29GL064M90TFIR4)
> - *
> - * Layout as used by D-Link:
> - *  0x00000000-0x00010000 : "MTD1"
> - *  0x00010000-0x00020000 : "MTD2"
> - *  0x00020000-0x001a0000 : "Linux Kernel"
> - *  0x001a0000-0x007d0000 : "File System"
> - *  0x007d0000-0x00800000 : "u-boot"
> - */
> -
> -#define DNS323_NOR_BOOT_BASE 0xf4000000
> -#define DNS323_NOR_BOOT_SIZE SZ_8M
> -
> -static struct mtd_partition dns323_partitions[] =3D {
> -       {
> -               .name   =3D "MTD1",
> -               .size   =3D 0x00010000,
> -               .offset =3D 0,
> -       }, {
> -               .name   =3D "MTD2",
> -               .size   =3D 0x00010000,
> -               .offset =3D 0x00010000,
> -       }, {
> -               .name   =3D "Linux Kernel",
> -               .size   =3D 0x00180000,
> -               .offset =3D 0x00020000,
> -       }, {
> -               .name   =3D "File System",
> -               .size   =3D 0x00630000,
> -               .offset =3D 0x001A0000,
> -       }, {
> -               .name   =3D "u-boot",
> -               .size   =3D 0x00030000,
> -               .offset =3D 0x007d0000,
> -       },
> -};
> -
> -static struct physmap_flash_data dns323_nor_flash_data =3D {
> -       .width          =3D 1,
> -       .parts          =3D dns323_partitions,
> -       .nr_parts       =3D ARRAY_SIZE(dns323_partitions)
> -};
> -
> -static struct resource dns323_nor_flash_resource =3D {
> -       .flags          =3D IORESOURCE_MEM,
> -       .start          =3D DNS323_NOR_BOOT_BASE,
> -       .end            =3D DNS323_NOR_BOOT_BASE + DNS323_NOR_BOOT_SIZE -=
 1,
> -};
> -
> -static struct platform_device dns323_nor_flash =3D {
> -       .name           =3D "physmap-flash",
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &dns323_nor_flash_data,
> -       },
> -       .resource       =3D &dns323_nor_flash_resource,
> -       .num_resources  =3D 1,
> -};
> -
> -/***********************************************************************=
*****
> - * Ethernet
> - */
> -
> -static struct mv643xx_eth_platform_data dns323_eth_data =3D {
> -       .phy_addr =3D MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -/* dns323_parse_hex_*() taken from tsx09-common.c; should a common copy =
of these
> - * functions be kept somewhere?
> - */
> -static int __init dns323_parse_hex_nibble(char n)
> -{
> -       if (n >=3D '0' && n <=3D '9')
> -               return n - '0';
> -
> -       if (n >=3D 'A' && n <=3D 'F')
> -               return n - 'A' + 10;
> -
> -       if (n >=3D 'a' && n <=3D 'f')
> -               return n - 'a' + 10;
> -
> -       return -1;
> -}
> -
> -static int __init dns323_parse_hex_byte(const char *b)
> -{
> -       int hi;
> -       int lo;
> -
> -       hi =3D dns323_parse_hex_nibble(b[0]);
> -       lo =3D dns323_parse_hex_nibble(b[1]);
> -
> -       if (hi < 0 || lo < 0)
> -               return -1;
> -
> -       return (hi << 4) | lo;
> -}
> -
> -static int __init dns323_read_mac_addr(void)
> -{
> -       u_int8_t addr[6];
> -       int i;
> -       char *mac_page;
> -
> -       /* MAC address is stored as a regular ol' string in /dev/mtdblock=
4
> -        * (0x007d0000-0x00800000) starting at offset 196480 (0x2ff80).
> -        */
> -       mac_page =3D ioremap(DNS323_NOR_BOOT_BASE + 0x7d0000 + 196480, 10=
24);
> -       if (!mac_page)
> -               return -ENOMEM;
> -
> -       /* Sanity check the string we're looking at */
> -       for (i =3D 0; i < 5; i++) {
> -               if (*(mac_page + (i * 3) + 2) !=3D ':') {
> -                       goto error_fail;
> -               }
> -       }
> -
> -       for (i =3D 0; i < 6; i++) {
> -               int byte;
> -
> -               byte =3D dns323_parse_hex_byte(mac_page + (i * 3));
> -               if (byte < 0) {
> -                       goto error_fail;
> -               }
> -
> -               addr[i] =3D byte;
> -       }
> -
> -       iounmap(mac_page);
> -       printk("DNS-323: Found ethernet MAC address: %pM\n", addr);
> -
> -       memcpy(dns323_eth_data.mac_addr, addr, 6);
> -
> -       return 0;
> -
> -error_fail:
> -       iounmap(mac_page);
> -       return -EINVAL;
> -}
> -
> -/***********************************************************************=
*****
> - * GPIO LEDs (simple - doesn't use hardware blinking support)
> - */
> -
> -static struct gpio_led dns323ab_leds[] =3D {
> -       {
> -               .name =3D "power:blue",
> -               .default_trigger =3D "default-on",
> -       }, {
> -               .name =3D "right:amber",
> -       }, {
> -               .name =3D "left:amber",
> -       },
> -};
> -
> -static struct gpiod_lookup_table dns323a1_leds_gpio_table =3D {
> -       .dev_id =3D "leds-gpio",
> -       .table =3D {
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323_GPIO_LED_POWER2, NU=
LL,
> -                               0, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323_GPIO_LED_RIGHT_AMBE=
R, NULL,
> -                               1, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323_GPIO_LED_LEFT_AMBER=
, NULL,
> -                               2, GPIO_ACTIVE_LOW),
> -               { },
> -       },
> -};
> -
> -/* B1 is the same but power LED is active high */
> -static struct gpiod_lookup_table dns323b1_leds_gpio_table =3D {
> -       .dev_id =3D "leds-gpio",
> -       .table =3D {
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323_GPIO_LED_POWER2, NU=
LL,
> -                               0, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323_GPIO_LED_RIGHT_AMBE=
R, NULL,
> -                               1, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323_GPIO_LED_LEFT_AMBER=
, NULL,
> -                               2, GPIO_ACTIVE_LOW),
> -               { },
> -       },
> -};
> -
> -static struct gpio_led dns323c_leds[] =3D {
> -       {
> -               .name =3D "power:blue",
> -               .default_trigger =3D "timer",
> -       }, {
> -               .name =3D "right:amber",
> -       }, {
> -               .name =3D "left:amber",
> -       },
> -};
> -
> -static struct gpiod_lookup_table dns323c_leds_gpio_table =3D {
> -       .dev_id =3D "leds-gpio",
> -       .table =3D {
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323C_GPIO_LED_POWER, NU=
LL,
> -                               0, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323C_GPIO_LED_RIGHT_AMB=
ER, NULL,
> -                               1, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", DNS323C_GPIO_LED_LEFT_AMBE=
R, NULL,
> -                               2, GPIO_ACTIVE_LOW),
> -               { },
> -       },
> -};
> -
> -static struct gpio_led_platform_data dns323ab_led_data =3D {
> -       .num_leds       =3D ARRAY_SIZE(dns323ab_leds),
> -       .leds           =3D dns323ab_leds,
> -       .gpio_blink_set =3D orion_gpio_led_blink_set,
> -};
> -
> -static struct gpio_led_platform_data dns323c_led_data =3D {
> -       .num_leds       =3D ARRAY_SIZE(dns323c_leds),
> -       .leds           =3D dns323c_leds,
> -       .gpio_blink_set =3D orion_gpio_led_blink_set,
> -};
> -
> -static struct platform_device dns323_gpio_leds =3D {
> -       .name           =3D "leds-gpio",
> -       .id             =3D -1,
> -       .dev            =3D {
> -               .platform_data  =3D &dns323ab_led_data,
> -       },
> -};
> -
> -/***********************************************************************=
*****
> - * GPIO Attached Keys
> - */
> -
> -static struct gpio_keys_button dns323ab_buttons[] =3D {
> -       {
> -               .code           =3D KEY_RESTART,
> -               .gpio           =3D DNS323_GPIO_KEY_RESET,
> -               .desc           =3D "Reset Button",
> -               .active_low     =3D 1,
> -       }, {
> -               .code           =3D KEY_POWER,
> -               .gpio           =3D DNS323_GPIO_KEY_POWER,
> -               .desc           =3D "Power Button",
> -               .active_low     =3D 1,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data dns323ab_button_data =3D {
> -       .buttons        =3D dns323ab_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(dns323ab_buttons),
> -};
> -
> -static struct gpio_keys_button dns323c_buttons[] =3D {
> -       {
> -               .code           =3D KEY_POWER,
> -               .gpio           =3D DNS323C_GPIO_KEY_POWER,
> -               .desc           =3D "Power Button",
> -               .active_low     =3D 1,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data dns323c_button_data =3D {
> -       .buttons        =3D dns323c_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(dns323c_buttons),
> -};
> -
> -static struct platform_device dns323_button_device =3D {
> -       .name           =3D "gpio-keys",
> -       .id             =3D -1,
> -       .num_resources  =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &dns323ab_button_data,
> -       },
> -};
> -
> -/***********************************************************************=
******
> - * SATA
> - */
> -static struct mv_sata_platform_data dns323_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -/***********************************************************************=
*****
> - * General Setup
> - */
> -static unsigned int dns323a_mpp_modes[] __initdata =3D {
> -       MPP0_PCIE_RST_OUTn,
> -       MPP1_GPIO,              /* right amber LED (sata ch0) */
> -       MPP2_GPIO,              /* left amber LED (sata ch1) */
> -       MPP3_UNUSED,
> -       MPP4_GPIO,              /* power button LED */
> -       MPP5_GPIO,              /* power button LED */
> -       MPP6_GPIO,              /* GMT G751-2f overtemp */
> -       MPP7_GPIO,              /* M41T80 nIRQ/OUT/SQW */
> -       MPP8_GPIO,              /* triggers power off */
> -       MPP9_GPIO,              /* power button switch */
> -       MPP10_GPIO,             /* reset button switch */
> -       MPP11_UNUSED,
> -       MPP12_UNUSED,
> -       MPP13_UNUSED,
> -       MPP14_UNUSED,
> -       MPP15_UNUSED,
> -       MPP16_UNUSED,
> -       MPP17_UNUSED,
> -       MPP18_UNUSED,
> -       MPP19_UNUSED,
> -       0,
> -};
> -
> -static unsigned int dns323b_mpp_modes[] __initdata =3D {
> -       MPP0_UNUSED,
> -       MPP1_GPIO,              /* right amber LED (sata ch0) */
> -       MPP2_GPIO,              /* left amber LED (sata ch1) */
> -       MPP3_GPIO,              /* system up flag */
> -       MPP4_GPIO,              /* power button LED */
> -       MPP5_GPIO,              /* power button LED */
> -       MPP6_GPIO,              /* GMT G751-2f overtemp */
> -       MPP7_GPIO,              /* M41T80 nIRQ/OUT/SQW */
> -       MPP8_GPIO,              /* triggers power off */
> -       MPP9_GPIO,              /* power button switch */
> -       MPP10_GPIO,             /* reset button switch */
> -       MPP11_UNUSED,
> -       MPP12_SATA_LED,
> -       MPP13_SATA_LED,
> -       MPP14_SATA_LED,
> -       MPP15_SATA_LED,
> -       MPP16_UNUSED,
> -       MPP17_UNUSED,
> -       MPP18_UNUSED,
> -       MPP19_UNUSED,
> -       0,
> -};
> -
> -static unsigned int dns323c_mpp_modes[] __initdata =3D {
> -       MPP0_GPIO,              /* ? input */
> -       MPP1_GPIO,              /* input power switch (0 =3D pressed) */
> -       MPP2_GPIO,              /* output power off */
> -       MPP3_UNUSED,            /* ? output */
> -       MPP4_UNUSED,            /* ? output */
> -       MPP5_UNUSED,            /* ? output */
> -       MPP6_UNUSED,            /* ? output */
> -       MPP7_UNUSED,            /* ? output */
> -       MPP8_GPIO,              /* i/o right amber LED */
> -       MPP9_GPIO,              /* i/o left amber LED */
> -       MPP10_GPIO,             /* input */
> -       MPP11_UNUSED,
> -       MPP12_SATA_LED,
> -       MPP13_SATA_LED,
> -       MPP14_SATA_LED,
> -       MPP15_SATA_LED,
> -       MPP16_UNUSED,
> -       MPP17_GPIO,             /* power button LED */
> -       MPP18_GPIO,             /* fan speed bit 0 */
> -       MPP19_GPIO,             /* fan speed bit 1 */
> -       0,
> -};
> -
> -/* Rev C1 Fan speed notes:
> - *
> - * The fan is controlled by 2 GPIOs on this board. The settings
> - * of the bits is as follow:
> - *
> - *  GPIO 18    GPIO 19    Fan
> - *
> - *    0          0        stopped
> - *    0          1        low speed
> - *    1          0        high speed
> - *    1          1        don't do that (*)
> - *
> - * (*) I think the two bits control two feed-in resistors into a fixed
> - *     PWN circuit, setting both bits will basically go a 'bit' faster
> - *     than high speed, but d-link doesn't do it and you may get out of
> - *     HW spec so don't do it.
> - */
> -
> -/*
> - * On the DNS-323 A1 and B1 the following devices are attached via I2C:
> - *
> - *  i2c addr | chip        | description
> - *  0x3e     | GMT G760Af  | fan speed PWM controller
> - *  0x48     | GMT G751-2f | temp. sensor and therm. watchdog (LM75 comp=
atible)
> - *  0x68     | ST M41T80   | RTC w/ alarm
> - */
> -static struct i2c_board_info __initdata dns323ab_i2c_devices[] =3D {
> -       {
> -               I2C_BOARD_INFO("g760a", 0x3e),
> -       }, {
> -               I2C_BOARD_INFO("lm75", 0x48),
> -       }, {
> -               I2C_BOARD_INFO("m41t80", 0x68),
> -       },
> -};
> -
> -/*
> - * On the DNS-323 C1 the following devices are attached via I2C:
> - *
> - *  i2c addr | chip        | description
> - *  0x48     | GMT G751-2f | temp. sensor and therm. watchdog (LM75 comp=
atible)
> - *  0x68     | ST M41T80   | RTC w/ alarm
> - */
> -static struct i2c_board_info __initdata dns323c_i2c_devices[] =3D {
> -       {
> -               I2C_BOARD_INFO("lm75", 0x48),
> -       }, {
> -               I2C_BOARD_INFO("m41t80", 0x68),
> -       },
> -};
> -
> -/* DNS-323 rev. A specific power off method */
> -static void dns323a_power_off(void)
> -{
> -       pr_info("DNS-323: Triggering power-off...\n");
> -       gpio_set_value(DNS323_GPIO_POWER_OFF, 1);
> -}
> -
> -/* DNS-323 rev B specific power off method */
> -static void dns323b_power_off(void)
> -{
> -       pr_info("DNS-323: Triggering power-off...\n");
> -       /* Pin has to be changed to 1 and back to 0 to do actual power of=
f. */
> -       gpio_set_value(DNS323_GPIO_POWER_OFF, 1);
> -       mdelay(100);
> -       gpio_set_value(DNS323_GPIO_POWER_OFF, 0);
> -}
> -
> -/* DNS-323 rev. C specific power off method */
> -static void dns323c_power_off(void)
> -{
> -       pr_info("DNS-323: Triggering power-off...\n");
> -       gpio_set_value(DNS323C_GPIO_POWER_OFF, 1);
> -}
> -
> -static int dns323c_phy_fixup(struct phy_device *phy)
> -{
> -       phy->dev_flags |=3D MARVELL_PHY_M1118_DNS323_LEDS;
> -
> -       return 0;
> -}
> -
> -static int __init dns323_identify_rev(void)
> -{
> -       u32 dev, rev, i, reg;
> -
> -       pr_debug("DNS-323: Identifying board ... \n");
> -
> -       /* Rev A1 has a 5181 */
> -       orion5x_pcie_id(&dev, &rev);
> -       if (dev =3D=3D MV88F5181_DEV_ID) {
> -               pr_debug("DNS-323: 5181 found, board is A1\n");
> -               return DNS323_REV_A1;
> -       }
> -       pr_debug("DNS-323: 5182 found, board is B1 or C1, checking PHY...=
\n");
> -
> -       /* Rev B1 and C1 both have 5182, let's poke at the eth PHY. This =
is
> -        * a bit gross but we want to do that without links into the eth
> -        * driver so let's poke at it directly. We default to rev B1 in
> -        * case the accesses fail
> -        */
> -
> -#define ETH_SMI_REG            (ORION5X_ETH_VIRT_BASE + 0x2000 + 0x004)
> -#define  SMI_BUSY              0x10000000
> -#define  SMI_READ_VALID                0x08000000
> -#define  SMI_OPCODE_READ       0x04000000
> -#define  SMI_OPCODE_WRITE      0x00000000
> -
> -       for (i =3D 0; i < 1000; i++) {
> -               reg =3D readl(ETH_SMI_REG);
> -               if (!(reg & SMI_BUSY))
> -                       break;
> -       }
> -       if (i >=3D 1000) {
> -               pr_warn("DNS-323: Timeout accessing PHY, assuming rev B1\=
n");
> -               return DNS323_REV_B1;
> -       }
> -       writel((3 << 21)        /* phy ID reg */ |
> -              (8 << 16)        /* phy addr */ |
> -              SMI_OPCODE_READ, ETH_SMI_REG);
> -       for (i =3D 0; i < 1000; i++) {
> -               reg =3D readl(ETH_SMI_REG);
> -               if (reg & SMI_READ_VALID)
> -                       break;
> -       }
> -       if (i >=3D 1000) {
> -               pr_warn("DNS-323: Timeout reading PHY, assuming rev B1\n"=
);
> -               return DNS323_REV_B1;
> -       }
> -       pr_debug("DNS-323: Ethernet PHY ID 0x%x\n", reg & 0xffff);
> -
> -       /* Note: the Marvell tools mask the ID with 0x3f0 before comparis=
on
> -        * but I don't see that making a difference here, at least with
> -        * any known Marvell PHY ID
> -        */
> -       switch(reg & 0xfff0) {
> -       case 0x0cc0: /* MV88E1111 */
> -               return DNS323_REV_B1;
> -       case 0x0e10: /* MV88E1118 */
> -               return DNS323_REV_C1;
> -       default:
> -               pr_warn("DNS-323: Unknown PHY ID 0x%04x, assuming rev B1\=
n",
> -                       reg & 0xffff);
> -       }
> -       return DNS323_REV_B1;
> -}
> -
> -static void __init dns323_init(void)
> -{
> -       /* Setup basic Orion functions. Need to be called early. */
> -       orion5x_init();
> -
> -       /* Identify revision */
> -       system_rev =3D dns323_identify_rev();
> -       pr_info("DNS-323: Identified HW revision %c1\n", 'A' + system_rev=
);
> -
> -       /* Just to be tricky, the 5182 has a completely different
> -        * set of MPP modes to the 5181.
> -        */
> -       switch(system_rev) {
> -       case DNS323_REV_A1:
> -               orion5x_mpp_conf(dns323a_mpp_modes);
> -               writel(0, MPP_DEV_CTRL);                /* DEV_D[31:16] *=
/
> -               break;
> -       case DNS323_REV_B1:
> -               orion5x_mpp_conf(dns323b_mpp_modes);
> -               break;
> -       case DNS323_REV_C1:
> -               orion5x_mpp_conf(dns323c_mpp_modes);
> -               break;
> -       }
> -
> -       /* setup flash mapping
> -        * CS3 holds a 8 MB Spansion S29GL064M90TFIR4
> -        */
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   DNS323_NOR_BOOT_BASE,
> -                                   DNS323_NOR_BOOT_SIZE);
> -       platform_device_register(&dns323_nor_flash);
> -
> -       /* Sort out LEDs, Buttons and i2c devices */
> -       switch(system_rev) {
> -       case DNS323_REV_A1:
> -               /* The 5181 power LED is active low and requires
> -                * DNS323_GPIO_LED_POWER1 to also be low.
> -                */
> -               gpiod_add_lookup_table(&dns323a1_leds_gpio_table);
> -               gpio_request(DNS323_GPIO_LED_POWER1, "Power Led Enable");
> -               gpio_direction_output(DNS323_GPIO_LED_POWER1, 0);
> -               i2c_register_board_info(0, dns323ab_i2c_devices,
> -                                       ARRAY_SIZE(dns323ab_i2c_devices))=
;
> -
> -               break;
> -       case DNS323_REV_B1:
> -               gpiod_add_lookup_table(&dns323b1_leds_gpio_table);
> -               i2c_register_board_info(0, dns323ab_i2c_devices,
> -                               ARRAY_SIZE(dns323ab_i2c_devices));
> -               break;
> -       case DNS323_REV_C1:
> -               /* Hookup LEDs & Buttons */
> -               gpiod_add_lookup_table(&dns323c_leds_gpio_table);
> -               dns323_gpio_leds.dev.platform_data =3D &dns323c_led_data;
> -               dns323_button_device.dev.platform_data =3D &dns323c_butto=
n_data;
> -
> -               /* Hookup i2c devices and fan driver */
> -               i2c_register_board_info(0, dns323c_i2c_devices,
> -                               ARRAY_SIZE(dns323c_i2c_devices));
> -               platform_device_register_simple("dns323c-fan", 0, NULL, 0=
);
> -
> -               /* Register fixup for the PHY LEDs */
> -               if (!IS_BUILTIN(CONFIG_PHYLIB))
> -                       break;
> -               phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1118,
> -                                          MARVELL_PHY_ID_MASK,
> -                                          dns323c_phy_fixup);
> -       }
> -
> -       platform_device_register(&dns323_gpio_leds);
> -       platform_device_register(&dns323_button_device);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       if (dns323_read_mac_addr() < 0)
> -               printk("DNS-323: Failed to read MAC address\n");
> -       orion5x_ehci0_init();
> -       orion5x_eth_init(&dns323_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_uart0_init();
> -
> -       /* Remaining GPIOs */
> -       switch(system_rev) {
> -       case DNS323_REV_A1:
> -               /* Poweroff GPIO */
> -               if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") !=3D =
0 ||
> -                   gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) !=3D =
0)
> -                       pr_err("DNS-323: failed to setup power-off GPIO\n=
");
> -               register_platform_power_off(dns323a_power_off);
> -               break;
> -       case DNS323_REV_B1:
> -               /* 5182 built-in SATA init */
> -               orion5x_sata_init(&dns323_sata_data);
> -
> -               /* The DNS323 rev B1 has flag to indicate the system is u=
p.
> -                * Without this flag set, power LED will flash and cannot=
 be
> -                * controlled via leds-gpio.
> -                */
> -               if (gpio_request(DNS323_GPIO_SYSTEM_UP, "SYS_READY") =3D=
=3D 0)
> -                       gpio_direction_output(DNS323_GPIO_SYSTEM_UP, 1);
> -
> -               /* Poweroff GPIO */
> -               if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") !=3D =
0 ||
> -                   gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) !=3D =
0)
> -                       pr_err("DNS-323: failed to setup power-off GPIO\n=
");
> -               register_platform_power_off(dns323b_power_off);
> -               break;
> -       case DNS323_REV_C1:
> -               /* 5182 built-in SATA init */
> -               orion5x_sata_init(&dns323_sata_data);
> -
> -               /* Poweroff GPIO */
> -               if (gpio_request(DNS323C_GPIO_POWER_OFF, "POWEROFF") !=3D=
 0 ||
> -                   gpio_direction_output(DNS323C_GPIO_POWER_OFF, 0) !=3D=
 0)
> -                       pr_err("DNS-323: failed to setup power-off GPIO\n=
");
> -               register_platform_power_off(dns323c_power_off);
> -
> -               /* Now, -this- should theoretically be done by the sata_m=
v driver
> -                * once I figure out what's going on there. Maybe the beh=
aviour
> -                * of the LEDs should be somewhat passed via the platform=
_data.
> -                * for now, just whack the register and make the LEDs hap=
py
> -                *
> -                * Note: AFAIK, rev B1 needs the same treatment but I'll =
let
> -                * somebody else test it.
> -                */
> -               writel(0x5, ORION5X_SATA_VIRT_BASE + 0x2c);
> -               break;
> -       }
> -}
> -
> -/* Warning: D-Link uses a wrong mach-type (=3D526) in their bootloader *=
/
> -MACHINE_START(DNS323, "D-Link DNS-323")
> -       /* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D dns323_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-or=
ion5x/kurobox_pro-setup.c
> deleted file mode 100644
> index e61b9ab06943..000000000000
> --- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
> +++ /dev/null
> @@ -1,407 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-orion5x/kurobox_pro-setup.c
> - *
> - * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
> - */
> -#include <linux/gpio/consumer.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/delay.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mtd/rawnand.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/i2c.h>
> -#include <linux/serial_reg.h>
> -#include <linux/ata_platform.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include <linux/platform_data/mtd-orion_nand.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -
> -/***********************************************************************=
******
> - * KUROBOX-PRO Info
> - ***********************************************************************=
*****/
> -
> -/*
> - * 256K NOR flash Device bus boot chip select
> - */
> -
> -#define KUROBOX_PRO_NOR_BOOT_BASE      0xf4000000
> -#define KUROBOX_PRO_NOR_BOOT_SIZE      SZ_256K
> -
> -/*
> - * 256M NAND flash on Device bus chip select 1
> - */
> -
> -#define KUROBOX_PRO_NAND_BASE          0xfc000000
> -#define KUROBOX_PRO_NAND_SIZE          SZ_2M
> -
> -/***********************************************************************=
******
> - * 256MB NAND Flash on Device bus CS0
> - ***********************************************************************=
*****/
> -
> -static struct mtd_partition kurobox_pro_nand_parts[] =3D {
> -       {
> -               .name   =3D "uImage",
> -               .offset =3D 0,
> -               .size   =3D SZ_4M,
> -       }, {
> -               .name   =3D "rootfs",
> -               .offset =3D SZ_4M,
> -               .size   =3D SZ_64M,
> -       }, {
> -               .name   =3D "extra",
> -               .offset =3D SZ_4M + SZ_64M,
> -               .size   =3D SZ_256M - (SZ_4M + SZ_64M),
> -       },
> -};
> -
> -static struct resource kurobox_pro_nand_resource =3D {
> -       .flags          =3D IORESOURCE_MEM,
> -       .start          =3D KUROBOX_PRO_NAND_BASE,
> -       .end            =3D KUROBOX_PRO_NAND_BASE + KUROBOX_PRO_NAND_SIZE=
 - 1,
> -};
> -
> -static struct orion_nand_data kurobox_pro_nand_data =3D {
> -       .parts          =3D kurobox_pro_nand_parts,
> -       .nr_parts       =3D ARRAY_SIZE(kurobox_pro_nand_parts),
> -       .cle            =3D 0,
> -       .ale            =3D 1,
> -       .width          =3D 8,
> -};
> -
> -static struct platform_device kurobox_pro_nand_flash =3D {
> -       .name           =3D "orion_nand",
> -       .id             =3D -1,
> -       .dev            =3D {
> -               .platform_data  =3D &kurobox_pro_nand_data,
> -       },
> -       .resource       =3D &kurobox_pro_nand_resource,
> -       .num_resources  =3D 1,
> -};
> -
> -/***********************************************************************=
******
> - * 256KB NOR Flash on BOOT Device
> - ***********************************************************************=
*****/
> -
> -static struct physmap_flash_data kurobox_pro_nor_flash_data =3D {
> -       .width          =3D 1,
> -};
> -
> -static struct resource kurobox_pro_nor_flash_resource =3D {
> -       .flags                  =3D IORESOURCE_MEM,
> -       .start                  =3D KUROBOX_PRO_NOR_BOOT_BASE,
> -       .end                    =3D KUROBOX_PRO_NOR_BOOT_BASE + KUROBOX_P=
RO_NOR_BOOT_SIZE - 1,
> -};
> -
> -static struct platform_device kurobox_pro_nor_flash =3D {
> -       .name                   =3D "physmap-flash",
> -       .id                     =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &kurobox_pro_nor_flash_data,
> -       },
> -       .num_resources          =3D 1,
> -       .resource               =3D &kurobox_pro_nor_flash_resource,
> -};
> -
> -/***********************************************************************=
******
> - * PCI
> - ***********************************************************************=
*****/
> -
> -static int __init kurobox_pro_pci_map_irq(const struct pci_dev *dev, u8 =
slot,
> -       u8 pin)
> -{
> -       int irq;
> -
> -       /*
> -        * Check for devices with hard-wired IRQs.
> -        */
> -       irq =3D orion5x_pci_map_irq(dev, slot, pin);
> -       if (irq !=3D -1)
> -               return irq;
> -
> -       /*
> -        * PCI isn't used on the Kuro
> -        */
> -       return -1;
> -}
> -
> -static struct hw_pci kurobox_pro_pci __initdata =3D {
> -       .nr_controllers =3D 2,
> -       .setup          =3D orion5x_pci_sys_setup,
> -       .scan           =3D orion5x_pci_sys_scan_bus,
> -       .map_irq        =3D kurobox_pro_pci_map_irq,
> -};
> -
> -static int __init kurobox_pro_pci_init(void)
> -{
> -       if (machine_is_kurobox_pro()) {
> -               orion5x_pci_disable();
> -               pci_common_init(&kurobox_pro_pci);
> -       }
> -
> -       return 0;
> -}
> -
> -subsys_initcall(kurobox_pro_pci_init);
> -
> -/***********************************************************************=
******
> - * Ethernet
> - ***********************************************************************=
*****/
> -
> -static struct mv643xx_eth_platform_data kurobox_pro_eth_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -/***********************************************************************=
******
> - * RTC 5C372a on I2C bus
> - ***********************************************************************=
*****/
> -static struct i2c_board_info __initdata kurobox_pro_i2c_rtc =3D {
> -       I2C_BOARD_INFO("rs5c372a", 0x32),
> -};
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -static struct mv_sata_platform_data kurobox_pro_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -/***********************************************************************=
******
> - * Kurobox Pro specific power off method via UART1-attached microcontrol=
ler
> - ***********************************************************************=
*****/
> -
> -#define UART1_REG(x)   (UART1_VIRT_BASE + ((UART_##x) << 2))
> -
> -static int kurobox_pro_miconread(unsigned char *buf, int count)
> -{
> -       int i;
> -       int timeout;
> -
> -       for (i =3D 0; i < count; i++) {
> -               timeout =3D 10;
> -
> -               while (!(readl(UART1_REG(LSR)) & UART_LSR_DR)) {
> -                       if (--timeout =3D=3D 0)
> -                               break;
> -                       udelay(1000);
> -               }
> -
> -               if (timeout =3D=3D 0)
> -                       break;
> -               buf[i] =3D readl(UART1_REG(RX));
> -       }
> -
> -       /* return read bytes */
> -       return i;
> -}
> -
> -static int kurobox_pro_miconwrite(const unsigned char *buf, int count)
> -{
> -       int i =3D 0;
> -
> -       while (count--) {
> -               while (!(readl(UART1_REG(LSR)) & UART_LSR_THRE))
> -                       barrier();
> -               writel(buf[i++], UART1_REG(TX));
> -       }
> -
> -       return 0;
> -}
> -
> -static int kurobox_pro_miconsend(const unsigned char *data, int count)
> -{
> -       int i;
> -       unsigned char checksum =3D 0;
> -       unsigned char recv_buf[40];
> -       unsigned char send_buf[40];
> -       unsigned char correct_ack[3];
> -       int retry =3D 2;
> -
> -       /* Generate checksum */
> -       for (i =3D 0; i < count; i++)
> -               checksum -=3D  data[i];
> -
> -       do {
> -               /* Send data */
> -               kurobox_pro_miconwrite(data, count);
> -
> -               /* send checksum */
> -               kurobox_pro_miconwrite(&checksum, 1);
> -
> -               if (kurobox_pro_miconread(recv_buf, sizeof(recv_buf)) <=
=3D 3) {
> -                       printk(KERN_ERR ">%s: receive failed.\n", __func_=
_);
> -
> -                       /* send preamble to clear the receive buffer */
> -                       memset(&send_buf, 0xff, sizeof(send_buf));
> -                       kurobox_pro_miconwrite(send_buf, sizeof(send_buf)=
);
> -
> -                       /* make dummy reads */
> -                       mdelay(100);
> -                       kurobox_pro_miconread(recv_buf, sizeof(recv_buf))=
;
> -               } else {
> -                       /* Generate expected ack */
> -                       correct_ack[0] =3D 0x01;
> -                       correct_ack[1] =3D data[1];
> -                       correct_ack[2] =3D 0x00;
> -
> -                       /* checksum Check */
> -                       if ((recv_buf[0] + recv_buf[1] + recv_buf[2] +
> -                            recv_buf[3]) & 0xFF) {
> -                               printk(KERN_ERR ">%s: Checksum Error : "
> -                                       "Received data[%02x, %02x, %02x, =
%02x]"
> -                                       "\n", __func__, recv_buf[0],
> -                                       recv_buf[1], recv_buf[2], recv_bu=
f[3]);
> -                       } else {
> -                               /* Check Received Data */
> -                               if (correct_ack[0] =3D=3D recv_buf[0] &&
> -                                   correct_ack[1] =3D=3D recv_buf[1] &&
> -                                   correct_ack[2] =3D=3D recv_buf[2]) {
> -                                       /* Interval for next command */
> -                                       mdelay(10);
> -
> -                                       /* Receive ACK */
> -                                       return 0;
> -                               }
> -                       }
> -                       /* Received NAK or illegal Data */
> -                       printk(KERN_ERR ">%s: Error : NAK or Illegal Data=
 "
> -                                       "Received\n", __func__);
> -               }
> -       } while (retry--);
> -
> -       /* Interval for next command */
> -       mdelay(10);
> -
> -       return -1;
> -}
> -
> -static void kurobox_pro_power_off(void)
> -{
> -       const unsigned char watchdogkill[]      =3D {0x01, 0x35, 0x00};
> -       const unsigned char shutdownwait[]      =3D {0x00, 0x0c};
> -       const unsigned char poweroff[]          =3D {0x00, 0x06};
> -       /* 38400 baud divisor */
> -       const unsigned divisor =3D ((orion5x_tclk + (8 * 38400)) / (16 * =
38400));
> -
> -       pr_info("%s: triggering power-off...\n", __func__);
> -
> -       /* hijack uart1 and reset into sane state (38400,8n1,even parity)=
 */
> -       writel(0x83, UART1_REG(LCR));
> -       writel(divisor & 0xff, UART1_REG(DLL));
> -       writel((divisor >> 8) & 0xff, UART1_REG(DLM));
> -       writel(0x1b, UART1_REG(LCR));
> -       writel(0x00, UART1_REG(IER));
> -       writel(0x07, UART1_REG(FCR));
> -       writel(0x00, UART1_REG(MCR));
> -
> -       /* Send the commands to shutdown the Kurobox Pro */
> -       kurobox_pro_miconsend(watchdogkill, sizeof(watchdogkill)) ;
> -       kurobox_pro_miconsend(shutdownwait, sizeof(shutdownwait)) ;
> -       kurobox_pro_miconsend(poweroff, sizeof(poweroff));
> -}
> -
> -/***********************************************************************=
******
> - * General Setup
> - ***********************************************************************=
*****/
> -static unsigned int kurobox_pro_mpp_modes[] __initdata =3D {
> -       MPP0_UNUSED,
> -       MPP1_UNUSED,
> -       MPP2_GPIO,              /* GPIO Micon */
> -       MPP3_GPIO,              /* GPIO Rtc */
> -       MPP4_UNUSED,
> -       MPP5_UNUSED,
> -       MPP6_NAND,              /* NAND Flash REn */
> -       MPP7_NAND,              /* NAND Flash WEn */
> -       MPP8_UNUSED,
> -       MPP9_UNUSED,
> -       MPP10_UNUSED,
> -       MPP11_UNUSED,
> -       MPP12_SATA_LED,         /* SATA 0 presence */
> -       MPP13_SATA_LED,         /* SATA 1 presence */
> -       MPP14_SATA_LED,         /* SATA 0 active */
> -       MPP15_SATA_LED,         /* SATA 1 active */
> -       MPP16_UART,             /* UART1 RXD */
> -       MPP17_UART,             /* UART1 TXD */
> -       MPP18_UART,             /* UART1 CTSn */
> -       MPP19_UART,             /* UART1 RTSn */
> -       0,
> -};
> -
> -static void __init kurobox_pro_init(void)
> -{
> -       /*
> -        * Setup basic Orion functions. Need to be called early.
> -        */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(kurobox_pro_mpp_modes);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       orion5x_ehci0_init();
> -       orion5x_ehci1_init();
> -       orion5x_eth_init(&kurobox_pro_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_sata_init(&kurobox_pro_sata_data);
> -       orion5x_uart0_init();
> -       orion5x_uart1_init();
> -       orion5x_xor_init();
> -
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   KUROBOX_PRO_NOR_BOOT_BASE,
> -                                   KUROBOX_PRO_NOR_BOOT_SIZE);
> -       platform_device_register(&kurobox_pro_nor_flash);
> -
> -       if (machine_is_kurobox_pro()) {
> -               mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(0),
> -                                           ORION_MBUS_DEVBUS_ATTR(0),
> -                                           KUROBOX_PRO_NAND_BASE,
> -                                           KUROBOX_PRO_NAND_SIZE);
> -               platform_device_register(&kurobox_pro_nand_flash);
> -       }
> -
> -       i2c_register_board_info(0, &kurobox_pro_i2c_rtc, 1);
> -
> -       /* register Kurobox Pro specific power-off method */
> -       register_platform_power_off(kurobox_pro_power_off);
> -}
> -
> -#ifdef CONFIG_MACH_KUROBOX_PRO
> -MACHINE_START(KUROBOX_PRO, "Buffalo/Revogear Kurobox Pro")
> -       /* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D kurobox_pro_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> -#endif
> -
> -#ifdef CONFIG_MACH_LINKSTATION_PRO
> -MACHINE_START(LINKSTATION_PRO, "Buffalo Linkstation Pro/Live")
> -       /* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D kurobox_pro_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> -#endif
> diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x=
/mv2120-setup.c
> deleted file mode 100644
> index b15fe5b7a0f9..000000000000
> --- a/arch/arm/mach-orion5x/mv2120-setup.c
> +++ /dev/null
> @@ -1,256 +0,0 @@
> -/*
> - * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> - * Copyright (C) 2008 Martin Michlmayr <tbm@cyrius.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU Lesser General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - */
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/irq.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/ata_platform.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -
> -#define MV2120_NOR_BOOT_BASE   0xf4000000
> -#define MV2120_NOR_BOOT_SIZE   SZ_512K
> -
> -#define MV2120_GPIO_RTC_IRQ    3
> -#define MV2120_GPIO_KEY_RESET  17
> -#define MV2120_GPIO_KEY_POWER  18
> -#define MV2120_GPIO_POWER_OFF  19
> -
> -
> -/***********************************************************************=
******
> - * Ethernet
> - ***********************************************************************=
*****/
> -static struct mv643xx_eth_platform_data mv2120_eth_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -static struct mv_sata_platform_data mv2120_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -static struct mtd_partition mv2120_partitions[] =3D {
> -       {
> -               .name   =3D "firmware",
> -               .size   =3D 0x00080000,
> -               .offset =3D 0,
> -       },
> -};
> -
> -static struct physmap_flash_data mv2120_nor_flash_data =3D {
> -       .width          =3D 1,
> -       .parts          =3D mv2120_partitions,
> -       .nr_parts       =3D ARRAY_SIZE(mv2120_partitions)
> -};
> -
> -static struct resource mv2120_nor_flash_resource =3D {
> -       .flags          =3D IORESOURCE_MEM,
> -       .start          =3D MV2120_NOR_BOOT_BASE,
> -       .end            =3D MV2120_NOR_BOOT_BASE + MV2120_NOR_BOOT_SIZE -=
 1,
> -};
> -
> -static struct platform_device mv2120_nor_flash =3D {
> -       .name           =3D "physmap-flash",
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &mv2120_nor_flash_data,
> -       },
> -       .resource       =3D &mv2120_nor_flash_resource,
> -       .num_resources  =3D 1,
> -};
> -
> -static struct gpio_keys_button mv2120_buttons[] =3D {
> -       {
> -               .code           =3D KEY_RESTART,
> -               .gpio           =3D MV2120_GPIO_KEY_RESET,
> -               .desc           =3D "reset",
> -               .active_low     =3D 1,
> -       }, {
> -               .code           =3D KEY_POWER,
> -               .gpio           =3D MV2120_GPIO_KEY_POWER,
> -               .desc           =3D "power",
> -               .active_low     =3D 1,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data mv2120_button_data =3D {
> -       .buttons        =3D mv2120_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(mv2120_buttons),
> -};
> -
> -static struct platform_device mv2120_button_device =3D {
> -       .name           =3D "gpio-keys",
> -       .id             =3D -1,
> -       .num_resources  =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &mv2120_button_data,
> -       },
> -};
> -
> -
> -/***********************************************************************=
*****
> - * General Setup
> - ***********************************************************************=
*****/
> -static unsigned int mv2120_mpp_modes[] __initdata =3D {
> -       MPP0_GPIO,              /* Sys status LED */
> -       MPP1_GPIO,              /* Sys error LED */
> -       MPP2_GPIO,              /* OverTemp interrupt */
> -       MPP3_GPIO,              /* RTC interrupt */
> -       MPP4_GPIO,              /* V_LED 5V */
> -       MPP5_GPIO,              /* V_LED 3.3V */
> -       MPP6_UNUSED,
> -       MPP7_UNUSED,
> -       MPP8_GPIO,              /* SATA 0 fail LED */
> -       MPP9_GPIO,              /* SATA 1 fail LED */
> -       MPP10_UNUSED,
> -       MPP11_UNUSED,
> -       MPP12_SATA_LED,         /* SATA 0 presence */
> -       MPP13_SATA_LED,         /* SATA 1 presence */
> -       MPP14_SATA_LED,         /* SATA 0 active */
> -       MPP15_SATA_LED,         /* SATA 1 active */
> -       MPP16_UNUSED,
> -       MPP17_GPIO,             /* Reset button */
> -       MPP18_GPIO,             /* Power button */
> -       MPP19_GPIO,             /* Power off */
> -       0,
> -};
> -
> -static struct i2c_board_info __initdata mv2120_i2c_rtc =3D {
> -       I2C_BOARD_INFO("pcf8563", 0x51),
> -       .irq    =3D 0,
> -};
> -
> -static struct gpio_led mv2120_led_pins[] =3D {
> -       {
> -               .name                   =3D "mv2120:blue:health",
> -       },
> -       {
> -               .name                   =3D "mv2120:red:health",
> -       },
> -       {
> -               .name                   =3D "mv2120:led:bright",
> -               .default_trigger        =3D "default-on",
> -       },
> -       {
> -               .name                   =3D "mv2120:led:dimmed",
> -       },
> -       {
> -               .name                   =3D "mv2120:red:sata0",
> -       },
> -       {
> -               .name                   =3D "mv2120:red:sata1",
> -       },
> -
> -};
> -
> -static struct gpiod_lookup_table mv2120_leds_gpio_table =3D {
> -       .dev_id =3D "leds-gpio",
> -       .table =3D {
> -               GPIO_LOOKUP_IDX("orion_gpio0", 0, NULL,
> -                               0, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 1, NULL,
> -                               1, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 4, NULL,
> -                               2, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 5, NULL,
> -                               3, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 8, NULL,
> -                               4, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 9, NULL,
> -                               5, GPIO_ACTIVE_LOW),
> -               { },
> -       },
> -};
> -
> -static struct gpio_led_platform_data mv2120_led_data =3D {
> -       .leds           =3D mv2120_led_pins,
> -       .num_leds       =3D ARRAY_SIZE(mv2120_led_pins),
> -};
> -
> -static struct platform_device mv2120_leds =3D {
> -       .name   =3D "leds-gpio",
> -       .id     =3D -1,
> -       .dev    =3D {
> -               .platform_data  =3D &mv2120_led_data,
> -       }
> -};
> -
> -static void mv2120_power_off(void)
> -{
> -       pr_info("%s: triggering power-off...\n", __func__);
> -       gpio_set_value(MV2120_GPIO_POWER_OFF, 0);
> -}
> -
> -static void __init mv2120_init(void)
> -{
> -       /* Setup basic Orion functions. Need to be called early. */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(mv2120_mpp_modes);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       orion5x_ehci0_init();
> -       orion5x_ehci1_init();
> -       orion5x_eth_init(&mv2120_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_sata_init(&mv2120_sata_data);
> -       orion5x_uart0_init();
> -       orion5x_xor_init();
> -
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   MV2120_NOR_BOOT_BASE,
> -                                   MV2120_NOR_BOOT_SIZE);
> -       platform_device_register(&mv2120_nor_flash);
> -
> -       platform_device_register(&mv2120_button_device);
> -
> -       if (gpio_request(MV2120_GPIO_RTC_IRQ, "rtc") =3D=3D 0) {
> -               if (gpio_direction_input(MV2120_GPIO_RTC_IRQ) =3D=3D 0)
> -                       mv2120_i2c_rtc.irq =3D gpio_to_irq(MV2120_GPIO_RT=
C_IRQ);
> -               else
> -                       gpio_free(MV2120_GPIO_RTC_IRQ);
> -       }
> -       i2c_register_board_info(0, &mv2120_i2c_rtc, 1);
> -       gpiod_add_lookup_table(&mv2120_leds_gpio_table);
> -       platform_device_register(&mv2120_leds);
> -
> -       /* register mv2120 specific power-off method */
> -       if (gpio_request(MV2120_GPIO_POWER_OFF, "POWEROFF") !=3D 0 ||
> -           gpio_direction_output(MV2120_GPIO_POWER_OFF, 1) !=3D 0)
> -               pr_err("mv2120: failed to setup power-off GPIO\n");
> -       register_platform_power_off(mv2120_power_off);
> -}
> -
> -/* Warning: HP uses a wrong mach-type (=3D526) in their bootloader */
> -MACHINE_START(MV2120, "HP Media Vault mv2120")
> -       /* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D mv2120_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5=
x/net2big-setup.c
> deleted file mode 100644
> index f04571e79805..000000000000
> --- a/arch/arm/mach-orion5x/net2big-setup.c
> +++ /dev/null
> @@ -1,444 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-orion5x/net2big-setup.c
> - *
> - * LaCie 2Big Network NAS setup
> - *
> - * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/ata_platform.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/delay.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <plat/orion-gpio.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -
> -/***********************************************************************=
******
> - * LaCie 2Big Network Info
> - ***********************************************************************=
*****/
> -
> -/*
> - * 512KB NOR flash Device bus boot chip select
> - */
> -
> -#define NET2BIG_NOR_BOOT_BASE          0xfff80000
> -#define NET2BIG_NOR_BOOT_SIZE          SZ_512K
> -
> -/***********************************************************************=
******
> - * 512KB NOR Flash on Boot Device
> - ***********************************************************************=
*****/
> -
> -/*
> - * TODO: Check write support on flash MX29LV400CBTC-70G
> - */
> -
> -static struct mtd_partition net2big_partitions[] =3D {
> -       {
> -               .name           =3D "Full512kb",
> -               .size           =3D MTDPART_SIZ_FULL,
> -               .offset         =3D 0x00000000,
> -               .mask_flags     =3D MTD_WRITEABLE,
> -       },
> -};
> -
> -static struct physmap_flash_data net2big_nor_flash_data =3D {
> -       .width          =3D 1,
> -       .parts          =3D net2big_partitions,
> -       .nr_parts       =3D ARRAY_SIZE(net2big_partitions),
> -};
> -
> -static struct resource net2big_nor_flash_resource =3D {
> -       .flags                  =3D IORESOURCE_MEM,
> -       .start                  =3D NET2BIG_NOR_BOOT_BASE,
> -       .end                    =3D NET2BIG_NOR_BOOT_BASE
> -                                       + NET2BIG_NOR_BOOT_SIZE - 1,
> -};
> -
> -static struct platform_device net2big_nor_flash =3D {
> -       .name                   =3D "physmap-flash",
> -       .id                     =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &net2big_nor_flash_data,
> -       },
> -       .num_resources          =3D 1,
> -       .resource               =3D &net2big_nor_flash_resource,
> -};
> -
> -/***********************************************************************=
******
> - * Ethernet
> - ***********************************************************************=
*****/
> -
> -static struct mv643xx_eth_platform_data net2big_eth_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -/***********************************************************************=
******
> - * I2C devices
> - ***********************************************************************=
*****/
> -
> -/*
> - * i2c addr | chip         | description
> - * 0x32     | Ricoh 5C372b | RTC
> - * 0x50     | HT24LC08     | eeprom (1kB)
> - */
> -static struct i2c_board_info __initdata net2big_i2c_devices[] =3D {
> -       {
> -               I2C_BOARD_INFO("rs5c372b", 0x32),
> -       }, {
> -               I2C_BOARD_INFO("24c08", 0x50),
> -       },
> -};
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -
> -static struct mv_sata_platform_data net2big_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -#define NET2BIG_GPIO_SATA_POWER_REQ    19
> -#define NET2BIG_GPIO_SATA0_POWER       23
> -#define NET2BIG_GPIO_SATA1_POWER       25
> -
> -static void __init net2big_sata_power_init(void)
> -{
> -       int err;
> -
> -       /* Configure GPIOs over MPP max number. */
> -       orion_gpio_set_valid(NET2BIG_GPIO_SATA0_POWER, 1);
> -       orion_gpio_set_valid(NET2BIG_GPIO_SATA1_POWER, 1);
> -
> -       err =3D gpio_request(NET2BIG_GPIO_SATA0_POWER, "SATA0 power statu=
s");
> -       if (err =3D=3D 0) {
> -               err =3D gpio_direction_input(NET2BIG_GPIO_SATA0_POWER);
> -               if (err)
> -                       gpio_free(NET2BIG_GPIO_SATA0_POWER);
> -       }
> -       if (err) {
> -               pr_err("net2big: failed to setup SATA0 power GPIO\n");
> -               return;
> -       }
> -
> -       err =3D gpio_request(NET2BIG_GPIO_SATA1_POWER, "SATA1 power statu=
s");
> -       if (err =3D=3D 0) {
> -               err =3D gpio_direction_input(NET2BIG_GPIO_SATA1_POWER);
> -               if (err)
> -                       gpio_free(NET2BIG_GPIO_SATA1_POWER);
> -       }
> -       if (err) {
> -               pr_err("net2big: failed to setup SATA1 power GPIO\n");
> -               goto err_free_1;
> -       }
> -
> -       err =3D gpio_request(NET2BIG_GPIO_SATA_POWER_REQ, "SATA power req=
uest");
> -       if (err =3D=3D 0) {
> -               err =3D gpio_direction_output(NET2BIG_GPIO_SATA_POWER_REQ=
, 0);
> -               if (err)
> -                       gpio_free(NET2BIG_GPIO_SATA_POWER_REQ);
> -       }
> -       if (err) {
> -               pr_err("net2big: failed to setup SATA power request GPIO\=
n");
> -               goto err_free_2;
> -       }
> -
> -       if (gpio_get_value(NET2BIG_GPIO_SATA0_POWER) &&
> -               gpio_get_value(NET2BIG_GPIO_SATA1_POWER)) {
> -               return;
> -       }
> -
> -       /*
> -        * SATA power up on both disk is done by pulling high the CPLD po=
wer
> -        * request line. The 300ms delay is related to the CPLD clock and=
 is
> -        * needed to be sure that the CPLD has take into account the low =
line
> -        * status.
> -        */
> -       msleep(300);
> -       gpio_set_value(NET2BIG_GPIO_SATA_POWER_REQ, 1);
> -       pr_info("net2big: power up SATA hard disks\n");
> -
> -       return;
> -
> -err_free_2:
> -       gpio_free(NET2BIG_GPIO_SATA1_POWER);
> -err_free_1:
> -       gpio_free(NET2BIG_GPIO_SATA0_POWER);
> -
> -       return;
> -}
> -
> -/***********************************************************************=
******
> - * GPIO LEDs
> - ***********************************************************************=
*****/
> -
> -/*
> - * The power front LEDs (blue and red) and SATA red LEDs are controlled =
via a
> - * single GPIO line and are compatible with the leds-gpio driver.
> - *
> - * The SATA blue LEDs have some hardware blink capabilities which are de=
tailed
> - * in the following array:
> - *
> - * SATAx blue LED | SATAx activity | LED state
> - *                |                |
> - *       0        |       0        |  blink (rate 300ms)
> - *       1        |       0        |  off
> - *       ?        |       1        |  on
> - *
> - * Notes: The blue and the red front LED's can't be on at the same time.
> - *        Blue LED have priority.
> - */
> -
> -#define NET2BIG_GPIO_PWR_RED_LED       6
> -#define NET2BIG_GPIO_PWR_BLUE_LED      16
> -#define NET2BIG_GPIO_PWR_LED_BLINK_STOP        7
> -
> -#define NET2BIG_GPIO_SATA0_RED_LED     11
> -#define NET2BIG_GPIO_SATA1_RED_LED     10
> -
> -#define NET2BIG_GPIO_SATA0_BLUE_LED    17
> -#define NET2BIG_GPIO_SATA1_BLUE_LED    13
> -
> -static struct gpio_led net2big_leds[] =3D {
> -       {
> -               .name =3D "net2big:red:power",
> -       },
> -       {
> -               .name =3D "net2big:blue:power",
> -       },
> -       {
> -               .name =3D "net2big:red:sata0",
> -       },
> -       {
> -               .name =3D "net2big:red:sata1",
> -       },
> -};
> -
> -static struct gpiod_lookup_table net2big_leds_gpio_table =3D {
> -       .dev_id =3D "leds-gpio",
> -       .table =3D {
> -               GPIO_LOOKUP_IDX("orion_gpio0", NET2BIG_GPIO_PWR_RED_LED, =
NULL,
> -                               0, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", NET2BIG_GPIO_PWR_BLUE_LED,=
 NULL,
> -                               1, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", NET2BIG_GPIO_SATA0_RED_LED=
, NULL,
> -                               2, GPIO_ACTIVE_HIGH),
> -               GPIO_LOOKUP_IDX("orion_gpio0", NET2BIG_GPIO_SATA1_RED_LED=
, NULL,
> -                               3, GPIO_ACTIVE_HIGH),
> -               { },
> -       },
> -};
> -
> -static struct gpio_led_platform_data net2big_led_data =3D {
> -       .num_leds =3D ARRAY_SIZE(net2big_leds),
> -       .leds =3D net2big_leds,
> -};
> -
> -static struct platform_device net2big_gpio_leds =3D {
> -       .name           =3D "leds-gpio",
> -       .id             =3D -1,
> -       .dev            =3D {
> -               .platform_data  =3D &net2big_led_data,
> -       },
> -};
> -
> -static void __init net2big_gpio_leds_init(void)
> -{
> -       int err;
> -
> -       /* Stop initial CPLD slow red/blue blinking on power LED. */
> -       err =3D gpio_request(NET2BIG_GPIO_PWR_LED_BLINK_STOP,
> -                          "Power LED blink stop");
> -       if (err =3D=3D 0) {
> -               err =3D gpio_direction_output(NET2BIG_GPIO_PWR_LED_BLINK_=
STOP, 1);
> -               if (err)
> -                       gpio_free(NET2BIG_GPIO_PWR_LED_BLINK_STOP);
> -       }
> -       if (err)
> -               pr_err("net2big: failed to setup power LED blink GPIO\n")=
;
> -
> -       /*
> -        * Configure SATA0 and SATA1 blue LEDs to blink in relation with =
the
> -        * hard disk activity.
> -        */
> -       err =3D gpio_request(NET2BIG_GPIO_SATA0_BLUE_LED,
> -                          "SATA0 blue LED control");
> -       if (err =3D=3D 0) {
> -               err =3D gpio_direction_output(NET2BIG_GPIO_SATA0_BLUE_LED=
, 1);
> -               if (err)
> -                       gpio_free(NET2BIG_GPIO_SATA0_BLUE_LED);
> -       }
> -       if (err)
> -               pr_err("net2big: failed to setup SATA0 blue LED GPIO\n");
> -
> -       err =3D gpio_request(NET2BIG_GPIO_SATA1_BLUE_LED,
> -                          "SATA1 blue LED control");
> -       if (err =3D=3D 0) {
> -               err =3D gpio_direction_output(NET2BIG_GPIO_SATA1_BLUE_LED=
, 1);
> -               if (err)
> -                       gpio_free(NET2BIG_GPIO_SATA1_BLUE_LED);
> -       }
> -       if (err)
> -               pr_err("net2big: failed to setup SATA1 blue LED GPIO\n");
> -
> -       gpiod_add_lookup_table(&net2big_leds_gpio_table);
> -       platform_device_register(&net2big_gpio_leds);
> -}
> -
> -/***********************************************************************=
*****
> - * GPIO keys
> - ***********************************************************************=
*****/
> -
> -#define NET2BIG_GPIO_PUSH_BUTTON       18
> -#define NET2BIG_GPIO_POWER_SWITCH_ON   8
> -#define NET2BIG_GPIO_POWER_SWITCH_OFF  9
> -
> -#define NET2BIG_SWITCH_POWER_ON                0x1
> -#define NET2BIG_SWITCH_POWER_OFF       0x2
> -
> -static struct gpio_keys_button net2big_buttons[] =3D {
> -       {
> -               .type           =3D EV_SW,
> -               .code           =3D NET2BIG_SWITCH_POWER_OFF,
> -               .gpio           =3D NET2BIG_GPIO_POWER_SWITCH_OFF,
> -               .desc           =3D "Power rocker switch (auto|off)",
> -               .active_low     =3D 0,
> -       },
> -       {
> -               .type           =3D EV_SW,
> -               .code           =3D NET2BIG_SWITCH_POWER_ON,
> -               .gpio           =3D NET2BIG_GPIO_POWER_SWITCH_ON,
> -               .desc           =3D "Power rocker switch (on|auto)",
> -               .active_low     =3D 0,
> -       },
> -       {
> -               .type           =3D EV_KEY,
> -               .code           =3D KEY_POWER,
> -               .gpio           =3D NET2BIG_GPIO_PUSH_BUTTON,
> -               .desc           =3D "Front Push Button",
> -               .active_low     =3D 0,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data net2big_button_data =3D {
> -       .buttons        =3D net2big_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(net2big_buttons),
> -};
> -
> -static struct platform_device net2big_gpio_buttons =3D {
> -       .name           =3D "gpio-keys",
> -       .id             =3D -1,
> -       .dev            =3D {
> -               .platform_data  =3D &net2big_button_data,
> -       },
> -};
> -
> -/***********************************************************************=
******
> - * General Setup
> - ***********************************************************************=
*****/
> -
> -static unsigned int net2big_mpp_modes[] __initdata =3D {
> -       MPP0_GPIO,      /* Raid mode (bit 0) */
> -       MPP1_GPIO,      /* USB port 2 fuse (0 =3D Fail, 1 =3D Ok) */
> -       MPP2_GPIO,      /* Raid mode (bit 1) */
> -       MPP3_GPIO,      /* Board ID (bit 0) */
> -       MPP4_GPIO,      /* Fan activity (0 =3D Off, 1 =3D On) */
> -       MPP5_GPIO,      /* Fan fail detection */
> -       MPP6_GPIO,      /* Red front LED (0 =3D Off, 1 =3D On) */
> -       MPP7_GPIO,      /* Disable initial blinking on front LED */
> -       MPP8_GPIO,      /* Rear power switch (on|auto) */
> -       MPP9_GPIO,      /* Rear power switch (auto|off) */
> -       MPP10_GPIO,     /* SATA 1 red LED (0 =3D Off, 1 =3D On) */
> -       MPP11_GPIO,     /* SATA 0 red LED (0 =3D Off, 1 =3D On) */
> -       MPP12_GPIO,     /* Board ID (bit 1) */
> -       MPP13_GPIO,     /* SATA 1 blue LED blink control */
> -       MPP14_SATA_LED,
> -       MPP15_SATA_LED,
> -       MPP16_GPIO,     /* Blue front LED control */
> -       MPP17_GPIO,     /* SATA 0 blue LED blink control */
> -       MPP18_GPIO,     /* Front button (0 =3D Released, 1 =3D Pushed ) *=
/
> -       MPP19_GPIO,     /* SATA{0,1} power On/Off request */
> -       0,
> -       /* 22: USB port 1 fuse (0 =3D Fail, 1 =3D Ok) */
> -       /* 23: SATA 0 power status */
> -       /* 24: Board power off */
> -       /* 25: SATA 1 power status */
> -};
> -
> -#define NET2BIG_GPIO_POWER_OFF         24
> -
> -static void net2big_power_off(void)
> -{
> -       gpio_set_value(NET2BIG_GPIO_POWER_OFF, 1);
> -}
> -
> -static void __init net2big_init(void)
> -{
> -       /*
> -        * Setup basic Orion functions. Need to be called early.
> -        */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(net2big_mpp_modes);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       orion5x_ehci0_init();
> -       orion5x_ehci1_init();
> -       orion5x_eth_init(&net2big_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_uart0_init();
> -       orion5x_xor_init();
> -
> -       net2big_sata_power_init();
> -       orion5x_sata_init(&net2big_sata_data);
> -
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   NET2BIG_NOR_BOOT_BASE,
> -                                   NET2BIG_NOR_BOOT_SIZE);
> -       platform_device_register(&net2big_nor_flash);
> -
> -       platform_device_register(&net2big_gpio_buttons);
> -       net2big_gpio_leds_init();
> -
> -       i2c_register_board_info(0, net2big_i2c_devices,
> -                               ARRAY_SIZE(net2big_i2c_devices));
> -
> -       orion_gpio_set_valid(NET2BIG_GPIO_POWER_OFF, 1);
> -
> -       if (gpio_request(NET2BIG_GPIO_POWER_OFF, "power-off") =3D=3D 0 &&
> -           gpio_direction_output(NET2BIG_GPIO_POWER_OFF, 0) =3D=3D 0)
> -               register_platform_power_off(net2big_power_off);
> -       else
> -               pr_err("net2big: failed to configure power-off GPIO\n");
> -
> -       pr_notice("net2big: Flash writing is not yet supported.\n");
> -}
> -
> -/* Warning: LaCie use a wrong mach-type (0x20e=3D526) in their bootloade=
r. */
> -MACHINE_START(NET2BIG, "LaCie 2Big Network")
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D net2big_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
> index 06f5320036b1..3d1e6ad0e14b 100644
> --- a/arch/arm/mach-orion5x/pci.c
> +++ b/arch/arm/mach-orion5x/pci.c
> @@ -15,7 +15,6 @@
>  #include <asm/irq.h>
>  #include <asm/mach/pci.h>
>  #include <plat/pcie.h>
> -#include <plat/addr-map.h>
>  #include "common.h"
>  #include "orion5x.h"
>
> diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/ma=
ch-orion5x/terastation_pro2-setup.c
> deleted file mode 100644
> index c3db3376950a..000000000000
> --- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
> +++ /dev/null
> @@ -1,366 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Buffalo Terastation Pro II/Live Board Setup
> - *
> - * Maintainer: Sylver Bruneau <sylver.bruneau@googlemail.com>
> - */
> -#include <linux/gpio/legacy.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/delay.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/i2c.h>
> -#include <linux/serial_reg.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -
> -/***********************************************************************=
******
> - * Terastation Pro 2/Live Info
> - ***********************************************************************=
*****/
> -
> -/*
> - * Terastation Pro 2 hardware :
> - * - Marvell 88F5281-D0
> - * - Marvell 88SX6042 SATA controller (PCI)
> - * - Marvell 88E1118 Gigabit Ethernet PHY
> - * - 256KB NOR flash
> - * - 128MB of DDR RAM
> - * - PCIe port (not equipped)
> - */
> -
> -/*
> - * 256K NOR flash Device bus boot chip select
> - */
> -
> -#define TSP2_NOR_BOOT_BASE     0xf4000000
> -#define TSP2_NOR_BOOT_SIZE     SZ_256K
> -
> -/***********************************************************************=
******
> - * 256KB NOR Flash on BOOT Device
> - ***********************************************************************=
*****/
> -
> -static struct physmap_flash_data tsp2_nor_flash_data =3D {
> -       .width    =3D 1,
> -};
> -
> -static struct resource tsp2_nor_flash_resource =3D {
> -       .flags =3D IORESOURCE_MEM,
> -       .start =3D TSP2_NOR_BOOT_BASE,
> -       .end   =3D TSP2_NOR_BOOT_BASE + TSP2_NOR_BOOT_SIZE - 1,
> -};
> -
> -static struct platform_device tsp2_nor_flash =3D {
> -       .name          =3D "physmap-flash",
> -       .id            =3D 0,
> -       .dev           =3D {
> -               .platform_data  =3D &tsp2_nor_flash_data,
> -       },
> -       .num_resources =3D 1,
> -       .resource      =3D &tsp2_nor_flash_resource,
> -};
> -
> -/***********************************************************************=
******
> - * PCI
> - ***********************************************************************=
*****/
> -#define TSP2_PCI_SLOT0_OFFS            7
> -#define TSP2_PCI_SLOT0_IRQ_PIN         11
> -
> -static void __init tsp2_pci_preinit(void)
> -{
> -       int pin;
> -
> -       /*
> -        * Configure PCI GPIO IRQ pins
> -        */
> -       pin =3D TSP2_PCI_SLOT0_IRQ_PIN;
> -       if (gpio_request(pin, "PCI Int1") =3D=3D 0) {
> -               if (gpio_direction_input(pin) =3D=3D 0) {
> -                       irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL=
_LOW);
> -               } else {
> -                       printk(KERN_ERR "tsp2_pci_preinit failed "
> -                                       "to set_irq_type pin %d\n", pin);
> -                       gpio_free(pin);
> -               }
> -       } else {
> -               printk(KERN_ERR "tsp2_pci_preinit failed to "
> -                               "gpio_request %d\n", pin);
> -       }
> -}
> -
> -static int __init tsp2_pci_map_irq(const struct pci_dev *dev, u8 slot, u=
8 pin)
> -{
> -       int irq;
> -
> -       /*
> -        * Check for devices with hard-wired IRQs.
> -        */
> -       irq =3D orion5x_pci_map_irq(dev, slot, pin);
> -       if (irq !=3D -1)
> -               return irq;
> -
> -       /*
> -        * PCI IRQs are connected via GPIOs.
> -        */
> -       if (slot =3D=3D TSP2_PCI_SLOT0_OFFS)
> -               return gpio_to_irq(TSP2_PCI_SLOT0_IRQ_PIN);
> -
> -       return -1;
> -}
> -
> -static struct hw_pci tsp2_pci __initdata =3D {
> -       .nr_controllers =3D 2,
> -       .preinit        =3D tsp2_pci_preinit,
> -       .setup          =3D orion5x_pci_sys_setup,
> -       .scan           =3D orion5x_pci_sys_scan_bus,
> -       .map_irq        =3D tsp2_pci_map_irq,
> -};
> -
> -static int __init tsp2_pci_init(void)
> -{
> -       if (machine_is_terastation_pro2())
> -               pci_common_init(&tsp2_pci);
> -
> -       return 0;
> -}
> -
> -subsys_initcall(tsp2_pci_init);
> -
> -/***********************************************************************=
******
> - * Ethernet
> - ***********************************************************************=
*****/
> -
> -static struct mv643xx_eth_platform_data tsp2_eth_data =3D {
> -       .phy_addr       =3D 0,
> -};
> -
> -/***********************************************************************=
******
> - * RTC 5C372a on I2C bus
> - ***********************************************************************=
*****/
> -
> -#define TSP2_RTC_GPIO  9
> -
> -static struct i2c_board_info __initdata tsp2_i2c_rtc =3D {
> -       I2C_BOARD_INFO("rs5c372a", 0x32),
> -};
> -
> -/***********************************************************************=
******
> - * Terastation Pro II specific power off method via UART1-attached
> - * microcontroller
> - ***********************************************************************=
*****/
> -
> -#define UART1_REG(x)   (UART1_VIRT_BASE + ((UART_##x) << 2))
> -
> -static int tsp2_miconread(unsigned char *buf, int count)
> -{
> -       int i;
> -       int timeout;
> -
> -       for (i =3D 0; i < count; i++) {
> -               timeout =3D 10;
> -
> -               while (!(readl(UART1_REG(LSR)) & UART_LSR_DR)) {
> -                       if (--timeout =3D=3D 0)
> -                               break;
> -                       udelay(1000);
> -               }
> -
> -               if (timeout =3D=3D 0)
> -                       break;
> -               buf[i] =3D readl(UART1_REG(RX));
> -       }
> -
> -       /* return read bytes */
> -       return i;
> -}
> -
> -static int tsp2_miconwrite(const unsigned char *buf, int count)
> -{
> -       int i =3D 0;
> -
> -       while (count--) {
> -               while (!(readl(UART1_REG(LSR)) & UART_LSR_THRE))
> -                       barrier();
> -               writel(buf[i++], UART1_REG(TX));
> -       }
> -
> -       return 0;
> -}
> -
> -static int tsp2_miconsend(const unsigned char *data, int count)
> -{
> -       int i;
> -       unsigned char checksum =3D 0;
> -       unsigned char recv_buf[40];
> -       unsigned char send_buf[40];
> -       unsigned char correct_ack[3];
> -       int retry =3D 2;
> -
> -       /* Generate checksum */
> -       for (i =3D 0; i < count; i++)
> -               checksum -=3D  data[i];
> -
> -       do {
> -               /* Send data */
> -               tsp2_miconwrite(data, count);
> -
> -               /* send checksum */
> -               tsp2_miconwrite(&checksum, 1);
> -
> -               if (tsp2_miconread(recv_buf, sizeof(recv_buf)) <=3D 3) {
> -                       printk(KERN_ERR ">%s: receive failed.\n", __func_=
_);
> -
> -                       /* send preamble to clear the receive buffer */
> -                       memset(&send_buf, 0xff, sizeof(send_buf));
> -                       tsp2_miconwrite(send_buf, sizeof(send_buf));
> -
> -                       /* make dummy reads */
> -                       mdelay(100);
> -                       tsp2_miconread(recv_buf, sizeof(recv_buf));
> -               } else {
> -                       /* Generate expected ack */
> -                       correct_ack[0] =3D 0x01;
> -                       correct_ack[1] =3D data[1];
> -                       correct_ack[2] =3D 0x00;
> -
> -                       /* checksum Check */
> -                       if ((recv_buf[0] + recv_buf[1] + recv_buf[2] +
> -                            recv_buf[3]) & 0xFF) {
> -                               printk(KERN_ERR ">%s: Checksum Error : "
> -                                       "Received data[%02x, %02x, %02x, =
%02x]"
> -                                       "\n", __func__, recv_buf[0],
> -                                       recv_buf[1], recv_buf[2], recv_bu=
f[3]);
> -                       } else {
> -                               /* Check Received Data */
> -                               if (correct_ack[0] =3D=3D recv_buf[0] &&
> -                                   correct_ack[1] =3D=3D recv_buf[1] &&
> -                                   correct_ack[2] =3D=3D recv_buf[2]) {
> -                                       /* Interval for next command */
> -                                       mdelay(10);
> -
> -                                       /* Receive ACK */
> -                                       return 0;
> -                               }
> -                       }
> -                       /* Received NAK or illegal Data */
> -                       printk(KERN_ERR ">%s: Error : NAK or Illegal Data=
 "
> -                                       "Received\n", __func__);
> -               }
> -       } while (retry--);
> -
> -       /* Interval for next command */
> -       mdelay(10);
> -
> -       return -1;
> -}
> -
> -static void tsp2_power_off(void)
> -{
> -       const unsigned char watchdogkill[]      =3D {0x01, 0x35, 0x00};
> -       const unsigned char shutdownwait[]      =3D {0x00, 0x0c};
> -       const unsigned char poweroff[]          =3D {0x00, 0x06};
> -       /* 38400 baud divisor */
> -       const unsigned divisor =3D ((orion5x_tclk + (8 * 38400)) / (16 * =
38400));
> -
> -       pr_info("%s: triggering power-off...\n", __func__);
> -
> -       /* hijack uart1 and reset into sane state (38400,8n1,even parity)=
 */
> -       writel(0x83, UART1_REG(LCR));
> -       writel(divisor & 0xff, UART1_REG(DLL));
> -       writel((divisor >> 8) & 0xff, UART1_REG(DLM));
> -       writel(0x1b, UART1_REG(LCR));
> -       writel(0x00, UART1_REG(IER));
> -       writel(0x07, UART1_REG(FCR));
> -       writel(0x00, UART1_REG(MCR));
> -
> -       /* Send the commands to shutdown the Terastation Pro II */
> -       tsp2_miconsend(watchdogkill, sizeof(watchdogkill)) ;
> -       tsp2_miconsend(shutdownwait, sizeof(shutdownwait)) ;
> -       tsp2_miconsend(poweroff, sizeof(poweroff));
> -}
> -
> -/***********************************************************************=
******
> - * General Setup
> - ***********************************************************************=
*****/
> -static unsigned int tsp2_mpp_modes[] __initdata =3D {
> -       MPP0_PCIE_RST_OUTn,
> -       MPP1_UNUSED,
> -       MPP2_UNUSED,
> -       MPP3_UNUSED,
> -       MPP4_NAND,              /* BOOT NAND Flash REn */
> -       MPP5_NAND,              /* BOOT NAND Flash WEn */
> -       MPP6_NAND,              /* BOOT NAND Flash HREn[0] */
> -       MPP7_NAND,              /* BOOT NAND Flash WEn[0] */
> -       MPP8_GPIO,              /* MICON int */
> -       MPP9_GPIO,              /* RTC int */
> -       MPP10_UNUSED,
> -       MPP11_GPIO,             /* PCI Int A */
> -       MPP12_UNUSED,
> -       MPP13_GPIO,             /* UPS on UART0 enable */
> -       MPP14_GPIO,             /* UPS low battery detection */
> -       MPP15_UNUSED,
> -       MPP16_UART,             /* UART1 RXD */
> -       MPP17_UART,             /* UART1 TXD */
> -       MPP18_UART,             /* UART1 CTSn */
> -       MPP19_UART,             /* UART1 RTSn */
> -       0,
> -};
> -
> -static void __init tsp2_init(void)
> -{
> -       /*
> -        * Setup basic Orion functions. Need to be called early.
> -        */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(tsp2_mpp_modes);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   TSP2_NOR_BOOT_BASE,
> -                                   TSP2_NOR_BOOT_SIZE);
> -       platform_device_register(&tsp2_nor_flash);
> -
> -       orion5x_ehci0_init();
> -       orion5x_eth_init(&tsp2_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_uart0_init();
> -       orion5x_uart1_init();
> -
> -       /* Get RTC IRQ and register the chip */
> -       if (gpio_request(TSP2_RTC_GPIO, "rtc") =3D=3D 0) {
> -               if (gpio_direction_input(TSP2_RTC_GPIO) =3D=3D 0)
> -                       tsp2_i2c_rtc.irq =3D gpio_to_irq(TSP2_RTC_GPIO);
> -               else
> -                       gpio_free(TSP2_RTC_GPIO);
> -       }
> -       if (tsp2_i2c_rtc.irq =3D=3D 0)
> -               pr_warn("tsp2_init: failed to get RTC IRQ\n");
> -       i2c_register_board_info(0, &tsp2_i2c_rtc, 1);
> -
> -       /* register Terastation Pro II specific power-off method */
> -       register_platform_power_off(tsp2_power_off);
> -}
> -
> -MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
> -       /* Maintainer:  Sylver Bruneau <sylver.bruneau@googlemail.com> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D tsp2_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/=
ts209-setup.c
> deleted file mode 100644
> index 25cd50306c65..000000000000
> --- a/arch/arm/mach-orion5x/ts209-setup.c
> +++ /dev/null
> @@ -1,331 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * QNAP TS-109/TS-209 Board Setup
> - *
> - * Maintainer: Byron Bradley <byron.bbradley@gmail.com>
> - */
> -#include <linux/gpio/legacy.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mtd/rawnand.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/serial_reg.h>
> -#include <linux/ata_platform.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -#include "tsx09-common.h"
> -
> -#define QNAP_TS209_NOR_BOOT_BASE 0xf4000000
> -#define QNAP_TS209_NOR_BOOT_SIZE SZ_8M
> -
> -/***********************************************************************=
*****
> - * 8MiB NOR flash. The struct mtd_partition is not in the same order as =
the
> - *     partitions on the device because we want to keep compatibility wi=
th
> - *     existing QNAP firmware.
> - *
> - * Layout as used by QNAP:
> - *  [2] 0x00000000-0x00200000 : "Kernel"
> - *  [3] 0x00200000-0x00600000 : "RootFS1"
> - *  [4] 0x00600000-0x00700000 : "RootFS2"
> - *  [6] 0x00700000-0x00760000 : "NAS Config" (read-only)
> - *  [5] 0x00760000-0x00780000 : "U-Boot Config"
> - *  [1] 0x00780000-0x00800000 : "U-Boot" (read-only)
> - ***********************************************************************=
****/
> -static struct mtd_partition qnap_ts209_partitions[] =3D {
> -       {
> -               .name           =3D "U-Boot",
> -               .size           =3D 0x00080000,
> -               .offset         =3D 0x00780000,
> -               .mask_flags     =3D MTD_WRITEABLE,
> -       }, {
> -               .name           =3D "Kernel",
> -               .size           =3D 0x00200000,
> -               .offset         =3D 0,
> -       }, {
> -               .name           =3D "RootFS1",
> -               .size           =3D 0x00400000,
> -               .offset         =3D 0x00200000,
> -       }, {
> -               .name           =3D "RootFS2",
> -               .size           =3D 0x00100000,
> -               .offset         =3D 0x00600000,
> -       }, {
> -               .name           =3D "U-Boot Config",
> -               .size           =3D 0x00020000,
> -               .offset         =3D 0x00760000,
> -       }, {
> -               .name           =3D "NAS Config",
> -               .size           =3D 0x00060000,
> -               .offset         =3D 0x00700000,
> -               .mask_flags     =3D MTD_WRITEABLE,
> -       },
> -};
> -
> -static struct physmap_flash_data qnap_ts209_nor_flash_data =3D {
> -       .width          =3D 1,
> -       .parts          =3D qnap_ts209_partitions,
> -       .nr_parts       =3D ARRAY_SIZE(qnap_ts209_partitions)
> -};
> -
> -static struct resource qnap_ts209_nor_flash_resource =3D {
> -       .flags  =3D IORESOURCE_MEM,
> -       .start  =3D QNAP_TS209_NOR_BOOT_BASE,
> -       .end    =3D QNAP_TS209_NOR_BOOT_BASE + QNAP_TS209_NOR_BOOT_SIZE -=
 1,
> -};
> -
> -static struct platform_device qnap_ts209_nor_flash =3D {
> -       .name           =3D "physmap-flash",
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &qnap_ts209_nor_flash_data,
> -       },
> -       .resource       =3D &qnap_ts209_nor_flash_resource,
> -       .num_resources  =3D 1,
> -};
> -
> -/***********************************************************************=
******
> - * PCI
> - ***********************************************************************=
*****/
> -
> -#define QNAP_TS209_PCI_SLOT0_OFFS      7
> -#define QNAP_TS209_PCI_SLOT0_IRQ_PIN   6
> -#define QNAP_TS209_PCI_SLOT1_IRQ_PIN   7
> -
> -static void __init qnap_ts209_pci_preinit(void)
> -{
> -       int pin;
> -
> -       /*
> -        * Configure PCI GPIO IRQ pins
> -        */
> -       pin =3D QNAP_TS209_PCI_SLOT0_IRQ_PIN;
> -       if (gpio_request(pin, "PCI Int1") =3D=3D 0) {
> -               if (gpio_direction_input(pin) =3D=3D 0) {
> -                       irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL=
_LOW);
> -               } else {
> -                       printk(KERN_ERR "qnap_ts209_pci_preinit failed to=
 "
> -                                       "set_irq_type pin %d\n", pin);
> -                       gpio_free(pin);
> -               }
> -       } else {
> -               printk(KERN_ERR "qnap_ts209_pci_preinit failed to gpio_re=
quest "
> -                               "%d\n", pin);
> -       }
> -
> -       pin =3D QNAP_TS209_PCI_SLOT1_IRQ_PIN;
> -       if (gpio_request(pin, "PCI Int2") =3D=3D 0) {
> -               if (gpio_direction_input(pin) =3D=3D 0) {
> -                       irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL=
_LOW);
> -               } else {
> -                       printk(KERN_ERR "qnap_ts209_pci_preinit failed "
> -                                       "to set_irq_type pin %d\n", pin);
> -                       gpio_free(pin);
> -               }
> -       } else {
> -               printk(KERN_ERR "qnap_ts209_pci_preinit failed to gpio_re=
quest "
> -                               "%d\n", pin);
> -       }
> -}
> -
> -static int __init qnap_ts209_pci_map_irq(const struct pci_dev *dev, u8 s=
lot,
> -       u8 pin)
> -{
> -       int irq;
> -
> -       /*
> -        * Check for devices with hard-wired IRQs.
> -        */
> -       irq =3D orion5x_pci_map_irq(dev, slot, pin);
> -       if (irq !=3D -1)
> -               return irq;
> -
> -       /*
> -        * PCI IRQs are connected via GPIOs.
> -        */
> -       switch (slot - QNAP_TS209_PCI_SLOT0_OFFS) {
> -       case 0:
> -               return gpio_to_irq(QNAP_TS209_PCI_SLOT0_IRQ_PIN);
> -       case 1:
> -               return gpio_to_irq(QNAP_TS209_PCI_SLOT1_IRQ_PIN);
> -       default:
> -               return -1;
> -       }
> -}
> -
> -static struct hw_pci qnap_ts209_pci __initdata =3D {
> -       .nr_controllers =3D 2,
> -       .preinit        =3D qnap_ts209_pci_preinit,
> -       .setup          =3D orion5x_pci_sys_setup,
> -       .scan           =3D orion5x_pci_sys_scan_bus,
> -       .map_irq        =3D qnap_ts209_pci_map_irq,
> -};
> -
> -static int __init qnap_ts209_pci_init(void)
> -{
> -       if (machine_is_ts209())
> -               pci_common_init(&qnap_ts209_pci);
> -
> -       return 0;
> -}
> -
> -subsys_initcall(qnap_ts209_pci_init);
> -
> -/***********************************************************************=
******
> - * RTC S35390A on I2C bus
> - ***********************************************************************=
*****/
> -
> -#define TS209_RTC_GPIO 3
> -
> -static struct i2c_board_info __initdata qnap_ts209_i2c_rtc =3D {
> -       I2C_BOARD_INFO("s35390a", 0x30),
> -       .irq    =3D 0,
> -};
> -
> -/***********************************************************************=
*****
> - * GPIO Attached Keys
> - *     Power button is attached to the PIC microcontroller
> - ***********************************************************************=
*****/
> -
> -#define QNAP_TS209_GPIO_KEY_MEDIA      1
> -#define QNAP_TS209_GPIO_KEY_RESET      2
> -
> -static struct gpio_keys_button qnap_ts209_buttons[] =3D {
> -       {
> -               .code           =3D KEY_COPY,
> -               .gpio           =3D QNAP_TS209_GPIO_KEY_MEDIA,
> -               .desc           =3D "USB Copy Button",
> -               .active_low     =3D 1,
> -       }, {
> -               .code           =3D KEY_RESTART,
> -               .gpio           =3D QNAP_TS209_GPIO_KEY_RESET,
> -               .desc           =3D "Reset Button",
> -               .active_low     =3D 1,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data qnap_ts209_button_data =3D {
> -       .buttons        =3D qnap_ts209_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(qnap_ts209_buttons),
> -};
> -
> -static struct platform_device qnap_ts209_button_device =3D {
> -       .name           =3D "gpio-keys",
> -       .id             =3D -1,
> -       .num_resources  =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &qnap_ts209_button_data,
> -       },
> -};
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -static struct mv_sata_platform_data qnap_ts209_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -/***********************************************************************=
******
> -
> - * General Setup
> - ***********************************************************************=
*****/
> -static unsigned int ts209_mpp_modes[] __initdata =3D {
> -       MPP0_UNUSED,
> -       MPP1_GPIO,              /* USB copy button */
> -       MPP2_GPIO,              /* Load defaults button */
> -       MPP3_GPIO,              /* GPIO RTC */
> -       MPP4_UNUSED,
> -       MPP5_UNUSED,
> -       MPP6_GPIO,              /* PCI Int A */
> -       MPP7_GPIO,              /* PCI Int B */
> -       MPP8_UNUSED,
> -       MPP9_UNUSED,
> -       MPP10_UNUSED,
> -       MPP11_UNUSED,
> -       MPP12_SATA_LED,         /* SATA 0 presence */
> -       MPP13_SATA_LED,         /* SATA 1 presence */
> -       MPP14_SATA_LED,         /* SATA 0 active */
> -       MPP15_SATA_LED,         /* SATA 1 active */
> -       MPP16_UART,             /* UART1 RXD */
> -       MPP17_UART,             /* UART1 TXD */
> -       MPP18_GPIO,             /* SW_RST */
> -       MPP19_UNUSED,
> -       0,
> -};
> -
> -static void __init qnap_ts209_init(void)
> -{
> -       /*
> -        * Setup basic Orion functions. Need to be called early.
> -        */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(ts209_mpp_modes);
> -
> -       /*
> -        * MPP[20] PCI clock 0
> -        * MPP[21] PCI clock 1
> -        * MPP[22] USB 0 over current
> -        * MPP[23-25] Reserved
> -        */
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   QNAP_TS209_NOR_BOOT_BASE,
> -                                   QNAP_TS209_NOR_BOOT_SIZE);
> -       platform_device_register(&qnap_ts209_nor_flash);
> -
> -       orion5x_ehci0_init();
> -       orion5x_ehci1_init();
> -       qnap_tsx09_find_mac_addr(QNAP_TS209_NOR_BOOT_BASE +
> -                                qnap_ts209_partitions[5].offset,
> -                                qnap_ts209_partitions[5].size);
> -       orion5x_eth_init(&qnap_tsx09_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_sata_init(&qnap_ts209_sata_data);
> -       orion5x_uart0_init();
> -       orion5x_uart1_init();
> -       orion5x_xor_init();
> -
> -       platform_device_register(&qnap_ts209_button_device);
> -
> -       /* Get RTC IRQ and register the chip */
> -       if (gpio_request(TS209_RTC_GPIO, "rtc") =3D=3D 0) {
> -               if (gpio_direction_input(TS209_RTC_GPIO) =3D=3D 0)
> -                       qnap_ts209_i2c_rtc.irq =3D gpio_to_irq(TS209_RTC_=
GPIO);
> -               else
> -                       gpio_free(TS209_RTC_GPIO);
> -       }
> -       if (qnap_ts209_i2c_rtc.irq =3D=3D 0)
> -               pr_warn("qnap_ts209_init: failed to get RTC IRQ\n");
> -       i2c_register_board_info(0, &qnap_ts209_i2c_rtc, 1);
> -
> -       /* register tsx09 specific power-off method */
> -       register_platform_power_off(qnap_tsx09_power_off);
> -}
> -
> -MACHINE_START(TS209, "QNAP TS-109/TS-209")
> -       /* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D qnap_ts209_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/=
ts409-setup.c
> deleted file mode 100644
> index f92acef0b45f..000000000000
> --- a/arch/arm/mach-orion5x/ts409-setup.c
> +++ /dev/null
> @@ -1,329 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * QNAP TS-409 Board Setup
> - *
> - * Maintainer: Sylver Bruneau <sylver.bruneau@gmail.com>
> - *
> - * Copyright (C) 2008  Sylver Bruneau <sylver.bruneau@gmail.com>
> - * Copyright (C) 2008  Martin Michlmayr <tbm@cyrius.com>
> - */
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/serial_reg.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -#include "tsx09-common.h"
> -
> -/***********************************************************************=
******
> - * QNAP TS-409 Info
> - ***********************************************************************=
*****/
> -
> -/*
> - * QNAP TS-409 hardware :
> - * - Marvell 88F5281-D0
> - * - Marvell 88SX7042 SATA controller (PCIe)
> - * - Marvell 88E1118 Gigabit Ethernet PHY
> - * - RTC S35390A (@0x30) on I2C bus
> - * - 8MB NOR flash
> - * - 256MB of DDR-2 RAM
> - */
> -
> -/*
> - * 8MB NOR flash Device bus boot chip select
> - */
> -
> -#define QNAP_TS409_NOR_BOOT_BASE 0xff800000
> -#define QNAP_TS409_NOR_BOOT_SIZE SZ_8M
> -
> -/***********************************************************************=
*****
> - * 8MiB NOR flash. The struct mtd_partition is not in the same order as =
the
> - *     partitions on the device because we want to keep compatibility wi=
th
> - *     existing QNAP firmware.
> - *
> - * Layout as used by QNAP:
> - *  [2] 0x00000000-0x00200000 : "Kernel"
> - *  [3] 0x00200000-0x00600000 : "RootFS1"
> - *  [4] 0x00600000-0x00700000 : "RootFS2"
> - *  [6] 0x00700000-0x00760000 : "NAS Config" (read-only)
> - *  [5] 0x00760000-0x00780000 : "U-Boot Config"
> - *  [1] 0x00780000-0x00800000 : "U-Boot" (read-only)
> - ***********************************************************************=
****/
> -static struct mtd_partition qnap_ts409_partitions[] =3D {
> -       {
> -               .name           =3D "U-Boot",
> -               .size           =3D 0x00080000,
> -               .offset         =3D 0x00780000,
> -               .mask_flags     =3D MTD_WRITEABLE,
> -       }, {
> -               .name           =3D "Kernel",
> -               .size           =3D 0x00200000,
> -               .offset         =3D 0,
> -       }, {
> -               .name           =3D "RootFS1",
> -               .size           =3D 0x00400000,
> -               .offset         =3D 0x00200000,
> -       }, {
> -               .name           =3D "RootFS2",
> -               .size           =3D 0x00100000,
> -               .offset         =3D 0x00600000,
> -       }, {
> -               .name           =3D "U-Boot Config",
> -               .size           =3D 0x00020000,
> -               .offset         =3D 0x00760000,
> -       }, {
> -               .name           =3D "NAS Config",
> -               .size           =3D 0x00060000,
> -               .offset         =3D 0x00700000,
> -               .mask_flags     =3D MTD_WRITEABLE,
> -       },
> -};
> -
> -static struct physmap_flash_data qnap_ts409_nor_flash_data =3D {
> -       .width          =3D 1,
> -       .parts          =3D qnap_ts409_partitions,
> -       .nr_parts       =3D ARRAY_SIZE(qnap_ts409_partitions)
> -};
> -
> -static struct resource qnap_ts409_nor_flash_resource =3D {
> -       .flags  =3D IORESOURCE_MEM,
> -       .start  =3D QNAP_TS409_NOR_BOOT_BASE,
> -       .end    =3D QNAP_TS409_NOR_BOOT_BASE + QNAP_TS409_NOR_BOOT_SIZE -=
 1,
> -};
> -
> -static struct platform_device qnap_ts409_nor_flash =3D {
> -       .name           =3D "physmap-flash",
> -       .id             =3D 0,
> -       .dev            =3D { .platform_data =3D &qnap_ts409_nor_flash_da=
ta, },
> -       .num_resources  =3D 1,
> -       .resource       =3D &qnap_ts409_nor_flash_resource,
> -};
> -
> -/***********************************************************************=
******
> - * PCI
> - ***********************************************************************=
*****/
> -
> -static int __init qnap_ts409_pci_map_irq(const struct pci_dev *dev, u8 s=
lot,
> -       u8 pin)
> -{
> -       int irq;
> -
> -       /*
> -        * Check for devices with hard-wired IRQs.
> -        */
> -       irq =3D orion5x_pci_map_irq(dev, slot, pin);
> -       if (irq !=3D -1)
> -               return irq;
> -
> -       /*
> -        * PCI isn't used on the TS-409
> -        */
> -       return -1;
> -}
> -
> -static struct hw_pci qnap_ts409_pci __initdata =3D {
> -       .nr_controllers =3D 2,
> -       .setup          =3D orion5x_pci_sys_setup,
> -       .scan           =3D orion5x_pci_sys_scan_bus,
> -       .map_irq        =3D qnap_ts409_pci_map_irq,
> -};
> -
> -static int __init qnap_ts409_pci_init(void)
> -{
> -       if (machine_is_ts409())
> -               pci_common_init(&qnap_ts409_pci);
> -
> -       return 0;
> -}
> -
> -subsys_initcall(qnap_ts409_pci_init);
> -
> -/***********************************************************************=
******
> - * RTC S35390A on I2C bus
> - ***********************************************************************=
*****/
> -
> -#define TS409_RTC_GPIO 10
> -
> -static struct i2c_board_info __initdata qnap_ts409_i2c_rtc =3D {
> -       I2C_BOARD_INFO("s35390a", 0x30),
> -};
> -
> -/***********************************************************************=
******
> - * LEDs attached to GPIO
> - ***********************************************************************=
*****/
> -
> -static struct gpio_led ts409_led_pins[] =3D {
> -       {
> -               .name           =3D "ts409:red:sata1",
> -       }, {
> -               .name           =3D "ts409:red:sata2",
> -       }, {
> -               .name           =3D "ts409:red:sata3",
> -       }, {
> -               .name           =3D "ts409:red:sata4",
> -       },
> -};
> -
> -static struct gpiod_lookup_table ts409_leds_gpio_table =3D {
> -       .dev_id =3D "leds-gpio",
> -       .table =3D {
> -               GPIO_LOOKUP_IDX("orion_gpio0", 4, NULL,
> -                               0, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 5, NULL,
> -                               1, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 6, NULL,
> -                               2, GPIO_ACTIVE_LOW),
> -               GPIO_LOOKUP_IDX("orion_gpio0", 7, NULL,
> -                               3, GPIO_ACTIVE_LOW),
> -               { },
> -       },
> -};
> -
> -static struct gpio_led_platform_data ts409_led_data =3D {
> -       .leds           =3D ts409_led_pins,
> -       .num_leds       =3D ARRAY_SIZE(ts409_led_pins),
> -};
> -
> -static struct platform_device ts409_leds =3D {
> -       .name   =3D "leds-gpio",
> -       .id     =3D -1,
> -       .dev    =3D {
> -               .platform_data  =3D &ts409_led_data,
> -       },
> -};
> -
> -/***********************************************************************=
*****
> - * GPIO Attached Keys
> - *     Power button is attached to the PIC microcontroller
> - ***********************************************************************=
*****/
> -
> -#define QNAP_TS409_GPIO_KEY_RESET      14
> -#define QNAP_TS409_GPIO_KEY_MEDIA      15
> -
> -static struct gpio_keys_button qnap_ts409_buttons[] =3D {
> -       {
> -               .code           =3D KEY_RESTART,
> -               .gpio           =3D QNAP_TS409_GPIO_KEY_RESET,
> -               .desc           =3D "Reset Button",
> -               .active_low     =3D 1,
> -       }, {
> -               .code           =3D KEY_COPY,
> -               .gpio           =3D QNAP_TS409_GPIO_KEY_MEDIA,
> -               .desc           =3D "USB Copy Button",
> -               .active_low     =3D 1,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data qnap_ts409_button_data =3D {
> -       .buttons        =3D qnap_ts409_buttons,
> -       .nbuttons       =3D ARRAY_SIZE(qnap_ts409_buttons),
> -};
> -
> -static struct platform_device qnap_ts409_button_device =3D {
> -       .name           =3D "gpio-keys",
> -       .id             =3D -1,
> -       .num_resources  =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &qnap_ts409_button_data,
> -       },
> -};
> -
> -/***********************************************************************=
******
> - * General Setup
> - ***********************************************************************=
*****/
> -static unsigned int ts409_mpp_modes[] __initdata =3D {
> -       MPP0_UNUSED,
> -       MPP1_UNUSED,
> -       MPP2_UNUSED,
> -       MPP3_UNUSED,
> -       MPP4_GPIO,              /* HDD 1 status */
> -       MPP5_GPIO,              /* HDD 2 status */
> -       MPP6_GPIO,              /* HDD 3 status */
> -       MPP7_GPIO,              /* HDD 4 status */
> -       MPP8_UNUSED,
> -       MPP9_UNUSED,
> -       MPP10_GPIO,             /* RTC int */
> -       MPP11_UNUSED,
> -       MPP12_UNUSED,
> -       MPP13_UNUSED,
> -       MPP14_GPIO,             /* SW_RST */
> -       MPP15_GPIO,             /* USB copy button */
> -       MPP16_UART,             /* UART1 RXD */
> -       MPP17_UART,             /* UART1 TXD */
> -       MPP18_UNUSED,
> -       MPP19_UNUSED,
> -       0,
> -};
> -
> -static void __init qnap_ts409_init(void)
> -{
> -       /*
> -        * Setup basic Orion functions. Need to be called early.
> -        */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(ts409_mpp_modes);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                                   ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                                   QNAP_TS409_NOR_BOOT_BASE,
> -                                   QNAP_TS409_NOR_BOOT_SIZE);
> -       platform_device_register(&qnap_ts409_nor_flash);
> -
> -       orion5x_ehci0_init();
> -       qnap_tsx09_find_mac_addr(QNAP_TS409_NOR_BOOT_BASE +
> -                                qnap_ts409_partitions[5].offset,
> -                                qnap_ts409_partitions[5].size);
> -       orion5x_eth_init(&qnap_tsx09_eth_data);
> -       orion5x_i2c_init();
> -       orion5x_uart0_init();
> -       orion5x_uart1_init();
> -
> -       platform_device_register(&qnap_ts409_button_device);
> -
> -       /* Get RTC IRQ and register the chip */
> -       if (gpio_request(TS409_RTC_GPIO, "rtc") =3D=3D 0) {
> -               if (gpio_direction_input(TS409_RTC_GPIO) =3D=3D 0)
> -                       qnap_ts409_i2c_rtc.irq =3D gpio_to_irq(TS409_RTC_=
GPIO);
> -               else
> -                       gpio_free(TS409_RTC_GPIO);
> -       }
> -       if (qnap_ts409_i2c_rtc.irq =3D=3D 0)
> -               pr_warn("qnap_ts409_init: failed to get RTC IRQ\n");
> -       i2c_register_board_info(0, &qnap_ts409_i2c_rtc, 1);
> -       gpiod_add_lookup_table(&ts409_leds_gpio_table);
> -       platform_device_register(&ts409_leds);
> -
> -       /* register tsx09 specific power-off method */
> -       register_platform_power_off(qnap_tsx09_power_off);
> -}
> -
> -MACHINE_START(TS409, "QNAP TS-409")
> -       /* Maintainer:  Sylver Bruneau <sylver.bruneau@gmail.com> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D qnap_ts409_init,
> -       .map_io         =3D orion5x_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .fixup          =3D tag_fixup_mem32,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/=
ts78xx-fpga.h
> deleted file mode 100644
> index 2f4fe3ca5c1a..000000000000
> --- a/arch/arm/mach-orion5x/ts78xx-fpga.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#define TS7800_FPGA_MAGIC 0x00b480
> -#define FPGAID(_magic, _rev) ((_magic << 8) + _rev)
> -
> -/*
> - * get yer id's from http://ts78xx.digriz.org.uk/
> - * do *not* make up your own or 'borrow' any!
> - */
> -enum fpga_ids {
> -       /* Technologic Systems */
> -       TS7800_REV_1    =3D FPGAID(TS7800_FPGA_MAGIC, 0x01),
> -       TS7800_REV_2    =3D FPGAID(TS7800_FPGA_MAGIC, 0x02),
> -       TS7800_REV_3    =3D FPGAID(TS7800_FPGA_MAGIC, 0x03),
> -       TS7800_REV_4    =3D FPGAID(TS7800_FPGA_MAGIC, 0x04),
> -       TS7800_REV_5    =3D FPGAID(TS7800_FPGA_MAGIC, 0x05),
> -       TS7800_REV_6    =3D FPGAID(TS7800_FPGA_MAGIC, 0x06),
> -       TS7800_REV_7    =3D FPGAID(TS7800_FPGA_MAGIC, 0x07),
> -       TS7800_REV_8    =3D FPGAID(TS7800_FPGA_MAGIC, 0x08),
> -       TS7800_REV_9    =3D FPGAID(TS7800_FPGA_MAGIC, 0x09),
> -
> -       /* Unaffordable & Expensive */
> -       UAE_DUMMY       =3D FPGAID(0xffffff, 0x01),
> -};
> -
> -struct fpga_device {
> -       unsigned                present:1;
> -       unsigned                init:1;
> -};
> -
> -struct fpga_devices {
> -       /* Technologic Systems */
> -       struct fpga_device      ts_rtc;
> -       struct fpga_device      ts_nand;
> -       struct fpga_device      ts_rng;
> -};
> -
> -struct ts78xx_fpga_data {
> -       unsigned int            id;
> -       int                     state;
> -
> -       struct fpga_devices     supports;
> -};
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x=
/ts78xx-setup.c
> deleted file mode 100644
> index af810e7ccd79..000000000000
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ /dev/null
> @@ -1,574 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * arch/arm/mach-orion5x/ts78xx-setup.c
> - *
> - * Maintainer: Alexander Clouter <alex@digriz.org.uk>
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/sysfs.h>
> -#include <linux/platform_device.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/ata_platform.h>
> -#include <linux/mtd/platnand.h>
> -#include <linux/timeriomem-rng.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/map.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -#include "ts78xx-fpga.h"
> -
> -/***********************************************************************=
******
> - * TS-78xx Info
> - ***********************************************************************=
*****/
> -
> -/*
> - * FPGA - lives where the PCI bus would be at ORION5X_PCI_MEM_PHYS_BASE
> - */
> -#define TS78XX_FPGA_REGS_PHYS_BASE     0xe8000000
> -#define TS78XX_FPGA_REGS_VIRT_BASE     IOMEM(0xff900000)
> -#define TS78XX_FPGA_REGS_SIZE          SZ_1M
> -
> -static struct ts78xx_fpga_data ts78xx_fpga =3D {
> -       .id             =3D 0,
> -       .state          =3D 1,
> -/*     .supports       =3D ... - populated by ts78xx_fpga_supports() */
> -};
> -
> -/***********************************************************************=
******
> - * I/O Address Mapping
> - ***********************************************************************=
*****/
> -static struct map_desc ts78xx_io_desc[] __initdata =3D {
> -       {
> -               .virtual        =3D (unsigned long)TS78XX_FPGA_REGS_VIRT_=
BASE,
> -               .pfn            =3D __phys_to_pfn(TS78XX_FPGA_REGS_PHYS_B=
ASE),
> -               .length         =3D TS78XX_FPGA_REGS_SIZE,
> -               .type           =3D MT_DEVICE,
> -       },
> -};
> -
> -static void __init ts78xx_map_io(void)
> -{
> -       orion5x_map_io();
> -       iotable_init(ts78xx_io_desc, ARRAY_SIZE(ts78xx_io_desc));
> -}
> -
> -/***********************************************************************=
******
> - * Ethernet
> - ***********************************************************************=
*****/
> -static struct mv643xx_eth_platform_data ts78xx_eth_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(0),
> -};
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -static struct mv_sata_platform_data ts78xx_sata_data =3D {
> -       .n_ports        =3D 2,
> -};
> -
> -/***********************************************************************=
******
> - * RTC M48T86 - nicked^Wborrowed from arch/arm/mach-ep93xx/ts72xx.c
> - ***********************************************************************=
*****/
> -#define TS_RTC_CTRL    (TS78XX_FPGA_REGS_PHYS_BASE + 0x808)
> -#define TS_RTC_DATA    (TS78XX_FPGA_REGS_PHYS_BASE + 0x80c)
> -
> -static struct resource ts78xx_ts_rtc_resources[] =3D {
> -       DEFINE_RES_MEM(TS_RTC_CTRL, 0x01),
> -       DEFINE_RES_MEM(TS_RTC_DATA, 0x01),
> -};
> -
> -static struct platform_device ts78xx_ts_rtc_device =3D {
> -       .name           =3D "rtc-m48t86",
> -       .id             =3D -1,
> -       .resource       =3D ts78xx_ts_rtc_resources,
> -       .num_resources  =3D ARRAY_SIZE(ts78xx_ts_rtc_resources),
> -};
> -
> -static int ts78xx_ts_rtc_load(void)
> -{
> -       int rc;
> -
> -       if (ts78xx_fpga.supports.ts_rtc.init =3D=3D 0) {
> -               rc =3D platform_device_register(&ts78xx_ts_rtc_device);
> -               if (!rc)
> -                       ts78xx_fpga.supports.ts_rtc.init =3D 1;
> -       } else {
> -               rc =3D platform_device_add(&ts78xx_ts_rtc_device);
> -       }
> -
> -       if (rc)
> -               pr_info("RTC could not be registered: %d\n", rc);
> -
> -       return rc;
> -}
> -
> -static void ts78xx_ts_rtc_unload(void)
> -{
> -       platform_device_del(&ts78xx_ts_rtc_device);
> -}
> -
> -/***********************************************************************=
******
> - * NAND Flash
> - ***********************************************************************=
*****/
> -#define TS_NAND_CTRL   (TS78XX_FPGA_REGS_VIRT_BASE + 0x800)    /* VIRT *=
/
> -#define TS_NAND_DATA   (TS78XX_FPGA_REGS_PHYS_BASE + 0x804)    /* PHYS *=
/
> -
> -/*
> - * hardware specific access to control-lines
> - *
> - * ctrl:
> - * NAND_NCE: bit 0 -> bit 2
> - * NAND_CLE: bit 1 -> bit 1
> - * NAND_ALE: bit 2 -> bit 0
> - */
> -static void ts78xx_ts_nand_cmd_ctrl(struct nand_chip *this, int cmd,
> -                                   unsigned int ctrl)
> -{
> -       if (ctrl & NAND_CTRL_CHANGE) {
> -               unsigned char bits;
> -
> -               bits =3D (ctrl & NAND_NCE) << 2;
> -               bits |=3D ctrl & NAND_CLE;
> -               bits |=3D (ctrl & NAND_ALE) >> 2;
> -
> -               writeb((readb(TS_NAND_CTRL) & ~0x7) | bits, TS_NAND_CTRL)=
;
> -       }
> -
> -       if (cmd !=3D NAND_CMD_NONE)
> -               writeb(cmd, this->legacy.IO_ADDR_W);
> -}
> -
> -static int ts78xx_ts_nand_dev_ready(struct nand_chip *chip)
> -{
> -       return readb(TS_NAND_CTRL) & 0x20;
> -}
> -
> -static void ts78xx_ts_nand_write_buf(struct nand_chip *chip,
> -                                    const uint8_t *buf, int len)
> -{
> -       void __iomem *io_base =3D chip->legacy.IO_ADDR_W;
> -       unsigned long off =3D ((unsigned long)buf & 3);
> -       int sz;
> -
> -       if (off) {
> -               sz =3D min_t(int, 4 - off, len);
> -               writesb(io_base, buf, sz);
> -               buf +=3D sz;
> -               len -=3D sz;
> -       }
> -
> -       sz =3D len >> 2;
> -       if (sz) {
> -               u32 *buf32 =3D (u32 *)buf;
> -               writesl(io_base, buf32, sz);
> -               buf +=3D sz << 2;
> -               len -=3D sz << 2;
> -       }
> -
> -       if (len)
> -               writesb(io_base, buf, len);
> -}
> -
> -static void ts78xx_ts_nand_read_buf(struct nand_chip *chip,
> -                                   uint8_t *buf, int len)
> -{
> -       void __iomem *io_base =3D chip->legacy.IO_ADDR_R;
> -       unsigned long off =3D ((unsigned long)buf & 3);
> -       int sz;
> -
> -       if (off) {
> -               sz =3D min_t(int, 4 - off, len);
> -               readsb(io_base, buf, sz);
> -               buf +=3D sz;
> -               len -=3D sz;
> -       }
> -
> -       sz =3D len >> 2;
> -       if (sz) {
> -               u32 *buf32 =3D (u32 *)buf;
> -               readsl(io_base, buf32, sz);
> -               buf +=3D sz << 2;
> -               len -=3D sz << 2;
> -       }
> -
> -       if (len)
> -               readsb(io_base, buf, len);
> -}
> -
> -static struct mtd_partition ts78xx_ts_nand_parts[] =3D {
> -       {
> -               .name           =3D "mbr",
> -               .offset         =3D 0,
> -               .size           =3D SZ_128K,
> -               .mask_flags     =3D MTD_WRITEABLE,
> -       }, {
> -               .name           =3D "kernel",
> -               .offset         =3D MTDPART_OFS_APPEND,
> -               .size           =3D SZ_4M,
> -       }, {
> -               .name           =3D "initrd",
> -               .offset         =3D MTDPART_OFS_APPEND,
> -               .size           =3D SZ_4M,
> -       }, {
> -               .name           =3D "rootfs",
> -               .offset         =3D MTDPART_OFS_APPEND,
> -               .size           =3D MTDPART_SIZ_FULL,
> -       }
> -};
> -
> -static struct platform_nand_data ts78xx_ts_nand_data =3D {
> -       .chip   =3D {
> -               .nr_chips               =3D 1,
> -               .partitions             =3D ts78xx_ts_nand_parts,
> -               .nr_partitions          =3D ARRAY_SIZE(ts78xx_ts_nand_par=
ts),
> -               .chip_delay             =3D 15,
> -               .bbt_options            =3D NAND_BBT_USE_FLASH,
> -       },
> -       .ctrl   =3D {
> -               /*
> -                * The HW ECC offloading functions, used to give about a =
9%
> -                * performance increase for 'dd if=3D/dev/mtdblockX' and =
5% for
> -                * nanddump.  This all however was changed by git commit
> -                * e6cf5df1838c28bb060ac45b5585e48e71bbc740 so now there =
is
> -                * no performance advantage to be had so we no longer bot=
her
> -                */
> -               .cmd_ctrl               =3D ts78xx_ts_nand_cmd_ctrl,
> -               .dev_ready              =3D ts78xx_ts_nand_dev_ready,
> -               .write_buf              =3D ts78xx_ts_nand_write_buf,
> -               .read_buf               =3D ts78xx_ts_nand_read_buf,
> -       },
> -};
> -
> -static struct resource ts78xx_ts_nand_resources
> -                       =3D DEFINE_RES_MEM(TS_NAND_DATA, 4);
> -
> -static struct platform_device ts78xx_ts_nand_device =3D {
> -       .name           =3D "gen_nand",
> -       .id             =3D -1,
> -       .dev            =3D {
> -               .platform_data  =3D &ts78xx_ts_nand_data,
> -       },
> -       .resource       =3D &ts78xx_ts_nand_resources,
> -       .num_resources  =3D 1,
> -};
> -
> -static int ts78xx_ts_nand_load(void)
> -{
> -       int rc;
> -
> -       if (ts78xx_fpga.supports.ts_nand.init =3D=3D 0) {
> -               rc =3D platform_device_register(&ts78xx_ts_nand_device);
> -               if (!rc)
> -                       ts78xx_fpga.supports.ts_nand.init =3D 1;
> -       } else
> -               rc =3D platform_device_add(&ts78xx_ts_nand_device);
> -
> -       if (rc)
> -               pr_info("NAND could not be registered: %d\n", rc);
> -       return rc;
> -};
> -
> -static void ts78xx_ts_nand_unload(void)
> -{
> -       platform_device_del(&ts78xx_ts_nand_device);
> -}
> -
> -/***********************************************************************=
******
> - * HW RNG
> - ***********************************************************************=
*****/
> -#define TS_RNG_DATA    (TS78XX_FPGA_REGS_PHYS_BASE | 0x044)
> -
> -static struct resource ts78xx_ts_rng_resource
> -                       =3D DEFINE_RES_MEM(TS_RNG_DATA, 4);
> -
> -static struct timeriomem_rng_data ts78xx_ts_rng_data =3D {
> -       .period         =3D 1000000, /* one second */
> -};
> -
> -static struct platform_device ts78xx_ts_rng_device =3D {
> -       .name           =3D "timeriomem_rng",
> -       .id             =3D -1,
> -       .dev            =3D {
> -               .platform_data  =3D &ts78xx_ts_rng_data,
> -       },
> -       .resource       =3D &ts78xx_ts_rng_resource,
> -       .num_resources  =3D 1,
> -};
> -
> -static int ts78xx_ts_rng_load(void)
> -{
> -       int rc;
> -
> -       if (ts78xx_fpga.supports.ts_rng.init =3D=3D 0) {
> -               rc =3D platform_device_register(&ts78xx_ts_rng_device);
> -               if (!rc)
> -                       ts78xx_fpga.supports.ts_rng.init =3D 1;
> -       } else
> -               rc =3D platform_device_add(&ts78xx_ts_rng_device);
> -
> -       if (rc)
> -               pr_info("RNG could not be registered: %d\n", rc);
> -       return rc;
> -};
> -
> -static void ts78xx_ts_rng_unload(void)
> -{
> -       platform_device_del(&ts78xx_ts_rng_device);
> -}
> -
> -/***********************************************************************=
******
> - * FPGA 'hotplug' support code
> - ***********************************************************************=
*****/
> -static void ts78xx_fpga_devices_zero_init(void)
> -{
> -       ts78xx_fpga.supports.ts_rtc.init =3D 0;
> -       ts78xx_fpga.supports.ts_nand.init =3D 0;
> -       ts78xx_fpga.supports.ts_rng.init =3D 0;
> -}
> -
> -static void ts78xx_fpga_supports(void)
> -{
> -       /* TODO: put this 'table' into ts78xx-fpga.h */
> -       switch (ts78xx_fpga.id) {
> -       case TS7800_REV_1:
> -       case TS7800_REV_2:
> -       case TS7800_REV_3:
> -       case TS7800_REV_4:
> -       case TS7800_REV_5:
> -       case TS7800_REV_6:
> -       case TS7800_REV_7:
> -       case TS7800_REV_8:
> -       case TS7800_REV_9:
> -               ts78xx_fpga.supports.ts_rtc.present =3D 1;
> -               ts78xx_fpga.supports.ts_nand.present =3D 1;
> -               ts78xx_fpga.supports.ts_rng.present =3D 1;
> -               break;
> -       default:
> -               /* enable devices if magic matches */
> -               switch ((ts78xx_fpga.id >> 8) & 0xffffff) {
> -               case TS7800_FPGA_MAGIC:
> -                       pr_warn("unrecognised FPGA revision 0x%.2x\n",
> -                               ts78xx_fpga.id & 0xff);
> -                       ts78xx_fpga.supports.ts_rtc.present =3D 1;
> -                       ts78xx_fpga.supports.ts_nand.present =3D 1;
> -                       ts78xx_fpga.supports.ts_rng.present =3D 1;
> -                       break;
> -               default:
> -                       ts78xx_fpga.supports.ts_rtc.present =3D 0;
> -                       ts78xx_fpga.supports.ts_nand.present =3D 0;
> -                       ts78xx_fpga.supports.ts_rng.present =3D 0;
> -               }
> -       }
> -}
> -
> -static int ts78xx_fpga_load_devices(void)
> -{
> -       int tmp, ret =3D 0;
> -
> -       if (ts78xx_fpga.supports.ts_rtc.present =3D=3D 1) {
> -               tmp =3D ts78xx_ts_rtc_load();
> -               if (tmp)
> -                       ts78xx_fpga.supports.ts_rtc.present =3D 0;
> -               ret |=3D tmp;
> -       }
> -       if (ts78xx_fpga.supports.ts_nand.present =3D=3D 1) {
> -               tmp =3D ts78xx_ts_nand_load();
> -               if (tmp)
> -                       ts78xx_fpga.supports.ts_nand.present =3D 0;
> -               ret |=3D tmp;
> -       }
> -       if (ts78xx_fpga.supports.ts_rng.present =3D=3D 1) {
> -               tmp =3D ts78xx_ts_rng_load();
> -               if (tmp)
> -                       ts78xx_fpga.supports.ts_rng.present =3D 0;
> -               ret |=3D tmp;
> -       }
> -
> -       return ret;
> -}
> -
> -static int ts78xx_fpga_unload_devices(void)
> -{
> -
> -       if (ts78xx_fpga.supports.ts_rtc.present =3D=3D 1)
> -               ts78xx_ts_rtc_unload();
> -       if (ts78xx_fpga.supports.ts_nand.present =3D=3D 1)
> -               ts78xx_ts_nand_unload();
> -       if (ts78xx_fpga.supports.ts_rng.present =3D=3D 1)
> -               ts78xx_ts_rng_unload();
> -
> -       return 0;
> -}
> -
> -static int ts78xx_fpga_load(void)
> -{
> -       ts78xx_fpga.id =3D readl(TS78XX_FPGA_REGS_VIRT_BASE);
> -
> -       pr_info("FPGA magic=3D0x%.6x, rev=3D0x%.2x\n",
> -                       (ts78xx_fpga.id >> 8) & 0xffffff,
> -                       ts78xx_fpga.id & 0xff);
> -
> -       ts78xx_fpga_supports();
> -
> -       if (ts78xx_fpga_load_devices()) {
> -               ts78xx_fpga.state =3D -1;
> -               return -EBUSY;
> -       }
> -
> -       return 0;
> -};
> -
> -static int ts78xx_fpga_unload(void)
> -{
> -       unsigned int fpga_id;
> -
> -       fpga_id =3D readl(TS78XX_FPGA_REGS_VIRT_BASE);
> -
> -       /*
> -        * There does not seem to be a feasible way to block access to th=
e GPIO
> -        * pins from userspace (/dev/mem).  This if clause should hopeful=
ly warn
> -        * those foolish enough not to follow 'policy' :)
> -        *
> -        * UrJTAG SVN since r1381 can be used to reprogram the FPGA
> -        */
> -       if (ts78xx_fpga.id !=3D fpga_id) {
> -               pr_err("FPGA magic/rev mismatch\n"
> -                       "TS-78xx FPGA: was 0x%.6x/%.2x but now 0x%.6x/%.2=
x\n",
> -                       (ts78xx_fpga.id >> 8) & 0xffffff, ts78xx_fpga.id =
& 0xff,
> -                       (fpga_id >> 8) & 0xffffff, fpga_id & 0xff);
> -               ts78xx_fpga.state =3D -1;
> -               return -EBUSY;
> -       }
> -
> -       if (ts78xx_fpga_unload_devices()) {
> -               ts78xx_fpga.state =3D -1;
> -               return -EBUSY;
> -       }
> -
> -       return 0;
> -};
> -
> -static ssize_t ts78xx_fpga_show(struct kobject *kobj,
> -                       struct kobj_attribute *attr, char *buf)
> -{
> -       if (ts78xx_fpga.state < 0)
> -               return sprintf(buf, "borked\n");
> -
> -       return sprintf(buf, "%s\n", (ts78xx_fpga.state) ? "online" : "off=
line");
> -}
> -
> -static ssize_t ts78xx_fpga_store(struct kobject *kobj,
> -                       struct kobj_attribute *attr, const char *buf, siz=
e_t n)
> -{
> -       int value, ret;
> -
> -       if (ts78xx_fpga.state < 0) {
> -               pr_err("FPGA borked, you must powercycle ASAP\n");
> -               return -EBUSY;
> -       }
> -
> -       if (strncmp(buf, "online", sizeof("online") - 1) =3D=3D 0)
> -               value =3D 1;
> -       else if (strncmp(buf, "offline", sizeof("offline") - 1) =3D=3D 0)
> -               value =3D 0;
> -       else
> -               return -EINVAL;
> -
> -       if (ts78xx_fpga.state =3D=3D value)
> -               return n;
> -
> -       ret =3D (ts78xx_fpga.state =3D=3D 0)
> -               ? ts78xx_fpga_load()
> -               : ts78xx_fpga_unload();
> -
> -       if (!(ret < 0))
> -               ts78xx_fpga.state =3D value;
> -
> -       return n;
> -}
> -
> -static struct kobj_attribute ts78xx_fpga_attr =3D
> -       __ATTR(ts78xx_fpga, 0644, ts78xx_fpga_show, ts78xx_fpga_store);
> -
> -/***********************************************************************=
******
> - * General Setup
> - ***********************************************************************=
*****/
> -static unsigned int ts78xx_mpp_modes[] __initdata =3D {
> -       MPP0_UNUSED,
> -       MPP1_GPIO,              /* JTAG Clock */
> -       MPP2_GPIO,              /* JTAG Data In */
> -       MPP3_GPIO,              /* Lat ECP2 256 FPGA - PB2B */
> -       MPP4_GPIO,              /* JTAG Data Out */
> -       MPP5_GPIO,              /* JTAG TMS */
> -       MPP6_GPIO,              /* Lat ECP2 256 FPGA - PB31A_CLK4+ */
> -       MPP7_GPIO,              /* Lat ECP2 256 FPGA - PB22B */
> -       MPP8_UNUSED,
> -       MPP9_UNUSED,
> -       MPP10_UNUSED,
> -       MPP11_UNUSED,
> -       MPP12_UNUSED,
> -       MPP13_UNUSED,
> -       MPP14_UNUSED,
> -       MPP15_UNUSED,
> -       MPP16_UART,
> -       MPP17_UART,
> -       MPP18_UART,
> -       MPP19_UART,
> -       /*
> -        * MPP[20] PCI Clock Out 1
> -        * MPP[21] PCI Clock Out 0
> -        * MPP[22] Unused
> -        * MPP[23] Unused
> -        * MPP[24] Unused
> -        * MPP[25] Unused
> -        */
> -       0,
> -};
> -
> -static void __init ts78xx_init(void)
> -{
> -       int ret;
> -
> -       /*
> -        * Setup basic Orion functions. Need to be called early.
> -        */
> -       orion5x_init();
> -
> -       orion5x_mpp_conf(ts78xx_mpp_modes);
> -
> -       /*
> -        * Configure peripherals.
> -        */
> -       orion5x_ehci0_init();
> -       orion5x_ehci1_init();
> -       orion5x_eth_init(&ts78xx_eth_data);
> -       orion5x_sata_init(&ts78xx_sata_data);
> -       orion5x_uart0_init();
> -       orion5x_uart1_init();
> -       orion5x_xor_init();
> -
> -       /* FPGA init */
> -       ts78xx_fpga_devices_zero_init();
> -       ret =3D ts78xx_fpga_load();
> -       ret =3D sysfs_create_file(firmware_kobj, &ts78xx_fpga_attr.attr);
> -       if (ret)
> -               pr_err("sysfs_create_file failed: %d\n", ret);
> -}
> -
> -MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
> -       /* Maintainer: Alexander Clouter <alex@digriz.org.uk> */
> -       .atag_offset    =3D 0x100,
> -       .nr_irqs        =3D ORION5X_NR_IRQS,
> -       .init_machine   =3D ts78xx_init,
> -       .map_io         =3D ts78xx_map_io,
> -       .init_early     =3D orion5x_init_early,
> -       .init_irq       =3D orion5x_init_irq,
> -       .init_time      =3D orion5x_timer_init,
> -       .restart        =3D orion5x_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x=
/tsx09-common.c
> deleted file mode 100644
> index 099e6fdfa8e6..000000000000
> --- a/arch/arm/mach-orion5x/tsx09-common.c
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * QNAP TS-x09 Boards common functions
> - *
> - * Maintainers: Lennert Buytenhek <buytenh@marvell.com>
> - *             Byron Bradley <byron.bbradley@gmail.com>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/pci.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/timex.h>
> -#include <linux/serial_reg.h>
> -#include "orion5x.h"
> -#include "tsx09-common.h"
> -#include "common.h"
> -
> -/***********************************************************************=
******
> - * QNAP TS-x09 specific power off method via UART1-attached PIC
> - ***********************************************************************=
*****/
> -
> -#define UART1_REG(x)   (UART1_VIRT_BASE + ((UART_##x) << 2))
> -
> -void qnap_tsx09_power_off(void)
> -{
> -       /* 19200 baud divisor */
> -       const unsigned divisor =3D ((orion5x_tclk + (8 * 19200)) / (16 * =
19200));
> -
> -       pr_info("%s: triggering power-off...\n", __func__);
> -
> -       /* hijack uart1 and reset into sane state (19200,8n1) */
> -       writel(0x83, UART1_REG(LCR));
> -       writel(divisor & 0xff, UART1_REG(DLL));
> -       writel((divisor >> 8) & 0xff, UART1_REG(DLM));
> -       writel(0x03, UART1_REG(LCR));
> -       writel(0x00, UART1_REG(IER));
> -       writel(0x00, UART1_REG(FCR));
> -       writel(0x00, UART1_REG(MCR));
> -
> -       /* send the power-off command 'A' to PIC */
> -       writel('A', UART1_REG(TX));
> -}
> -
> -/***********************************************************************=
******
> - * Ethernet
> - ***********************************************************************=
*****/
> -
> -struct mv643xx_eth_platform_data qnap_tsx09_eth_data =3D {
> -       .phy_addr       =3D MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -static int __init qnap_tsx09_parse_hex_nibble(char n)
> -{
> -       if (n >=3D '0' && n <=3D '9')
> -               return n - '0';
> -
> -       if (n >=3D 'A' && n <=3D 'F')
> -               return n - 'A' + 10;
> -
> -       if (n >=3D 'a' && n <=3D 'f')
> -               return n - 'a' + 10;
> -
> -       return -1;
> -}
> -
> -static int __init qnap_tsx09_parse_hex_byte(const char *b)
> -{
> -       int hi;
> -       int lo;
> -
> -       hi =3D qnap_tsx09_parse_hex_nibble(b[0]);
> -       lo =3D qnap_tsx09_parse_hex_nibble(b[1]);
> -
> -       if (hi < 0 || lo < 0)
> -               return -1;
> -
> -       return (hi << 4) | lo;
> -}
> -
> -static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
> -{
> -       u_int8_t addr[6];
> -       int i;
> -
> -       for (i =3D 0; i < 6; i++) {
> -               int byte;
> -
> -               /*
> -                * Enforce "xx:xx:xx:xx:xx:xx\n" format.
> -                */
> -               if (addr_str[(i * 3) + 2] !=3D ((i < 5) ? ':' : '\n'))
> -                       return -1;
> -
> -               byte =3D qnap_tsx09_parse_hex_byte(addr_str + (i * 3));
> -               if (byte < 0)
> -                       return -1;
> -               addr[i] =3D byte;
> -       }
> -
> -       printk(KERN_INFO "tsx09: found ethernet mac address %pM\n", addr)=
;
> -
> -       memcpy(qnap_tsx09_eth_data.mac_addr, addr, 6);
> -
> -       return 0;
> -}
> -
> -/*
> - * The 'NAS Config' flash partition has an ext2 filesystem which
> - * contains a file that has the ethernet MAC address in plain text
> - * (format "xx:xx:xx:xx:xx:xx\n").
> - */
> -void __init qnap_tsx09_find_mac_addr(u32 mem_base, u32 size)
> -{
> -       unsigned long addr;
> -
> -       for (addr =3D mem_base; addr < (mem_base + size); addr +=3D 1024)=
 {
> -               char *nor_page;
> -               int ret =3D 0;
> -
> -               nor_page =3D ioremap(addr, 1024);
> -               if (nor_page !=3D NULL) {
> -                       ret =3D qnap_tsx09_check_mac_addr(nor_page);
> -                       iounmap(nor_page);
> -               }
> -
> -               if (ret =3D=3D 0)
> -                       break;
> -       }
> -}
> diff --git a/arch/arm/mach-orion5x/tsx09-common.h b/arch/arm/mach-orion5x=
/tsx09-common.h
> deleted file mode 100644
> index 72bedc6b82fb..000000000000
> --- a/arch/arm/mach-orion5x/tsx09-common.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ARCH_ORION5X_TSX09_COMMON_H
> -#define __ARCH_ORION5X_TSX09_COMMON_H
> -
> -/*
> - * QNAP TS-x09 Boards power-off function
> - */
> -extern void qnap_tsx09_power_off(void);
> -
> -/*
> - * QNAP TS-x09 Boards function to find Ethernet MAC address in flash mem=
ory
> - */
> -extern void __init qnap_tsx09_find_mac_addr(u32 mem_base, u32 size);
> -
> -/*
> - * QNAP TS-x09 Boards ethernet declaration
> - */
> -extern struct mv643xx_eth_platform_data qnap_tsx09_eth_data;
> -
> -
> -#endif
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 6574659dfb61..c40cdb2274ea 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -980,7 +980,7 @@ config CACHE_B15_RAC
>
>  config CACHE_FEROCEON_L2
>         bool "Enable the Feroceon L2 cache controller"
> -       depends on ARCH_MV78XX0 || ARCH_MVEBU
> +       depends on ARCH_MVEBU
>         default y
>         select OUTER_CACHE
>         help
> diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
> index e8c7580df8ca..dfde39cdd992 100644
> --- a/arch/arm/plat-orion/Makefile
> +++ b/arch/arm/plat-orion/Makefile
> @@ -5,5 +5,5 @@
>  ccflags-y :=3D -I$(src)/include
>
>  orion-gpio-$(CONFIG_GPIOLIB)      +=3D gpio.o
> -obj-$(CONFIG_PLAT_ORION_LEGACY)   +=3D irq.o pcie.o time.o common.o mpp.=
o
> +obj-$(CONFIG_PLAT_ORION_LEGACY)   +=3D irq.o pcie.o mpp.o
>  obj-$(CONFIG_PLAT_ORION_LEGACY)   +=3D $(orion-gpio-y)
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> deleted file mode 100644
> index cabe98386245..000000000000
> --- a/arch/arm/plat-orion/common.c
> +++ /dev/null
> @@ -1,826 +0,0 @@
> -/*
> - * arch/arm/plat-orion/common.c
> - *
> - * Marvell Orion SoC common setup code used by multiple mach-/common.c
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/serial_8250.h>
> -#include <linux/ata_platform.h>
> -#include <linux/clk.h>
> -#include <linux/clkdev.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/mv643xx_i2c.h>
> -#include <linux/platform_data/dma-mv_xor.h>
> -#include <linux/platform_data/usb-ehci-orion.h>
> -#include <plat/common.h>
> -#include <linux/phy.h>
> -
> -/* Create a clkdev entry for a given device/clk */
> -void __init orion_clkdev_add(const char *con_id, const char *dev_id,
> -                            struct clk *clk)
> -{
> -       clkdev_create(clk, con_id, "%s", dev_id);
> -}
> -
> -/* Create clkdev entries for all orion platforms except kirkwood.
> -   Kirkwood has gated clocks for some of its peripherals, so creates
> -   its own clkdev entries. For all the other orion devices, create
> -   clkdev entries to the tclk. */
> -void __init orion_clkdev_init(struct clk *tclk)
> -{
> -       orion_clkdev_add(NULL, "orion_spi.0", tclk);
> -       orion_clkdev_add(NULL, "orion_spi.1", tclk);
> -       orion_clkdev_add(NULL, MV643XX_ETH_NAME ".0", tclk);
> -       orion_clkdev_add(NULL, MV643XX_ETH_NAME ".1", tclk);
> -       orion_clkdev_add(NULL, MV643XX_ETH_NAME ".2", tclk);
> -       orion_clkdev_add(NULL, MV643XX_ETH_NAME ".3", tclk);
> -       orion_clkdev_add(NULL, "orion_wdt", tclk);
> -       orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", tclk);
> -}
> -
> -/* Fill in the resources structure and link it into the platform
> -   device structure. There is always a memory region, and nearly
> -   always an interrupt.*/
> -static void fill_resources(struct platform_device *device,
> -                          struct resource *resources,
> -                          resource_size_t mapbase,
> -                          resource_size_t size)
> -{
> -       device->resource =3D resources;
> -       device->num_resources =3D 1;
> -       resources[0].flags =3D IORESOURCE_MEM;
> -       resources[0].start =3D mapbase;
> -       resources[0].end =3D mapbase + size;
> -}
> -
> -static void fill_resources_irq(struct platform_device *device,
> -                              struct resource *resources,
> -                              resource_size_t mapbase,
> -                              resource_size_t size,
> -                              unsigned int irq)
> -{
> -       fill_resources(device, resources, mapbase, size);
> -
> -       device->num_resources++;
> -       resources[1].flags =3D IORESOURCE_IRQ;
> -       resources[1].start =3D irq;
> -       resources[1].end =3D irq;
> -}
> -
> -/***********************************************************************=
******
> - * UART
> - ***********************************************************************=
*****/
> -static unsigned long __init uart_get_clk_rate(struct clk *clk)
> -{
> -       clk_prepare_enable(clk);
> -       return clk_get_rate(clk);
> -}
> -
> -static void __init uart_complete(
> -       struct platform_device *orion_uart,
> -       struct plat_serial8250_port *data,
> -       struct resource *resources,
> -       void __iomem *membase,
> -       resource_size_t mapbase,
> -       unsigned int irq,
> -       struct clk *clk)
> -{
> -       data->mapbase =3D mapbase;
> -       data->membase =3D membase;
> -       data->irq =3D irq;
> -       data->uartclk =3D uart_get_clk_rate(clk);
> -       orion_uart->dev.platform_data =3D data;
> -
> -       fill_resources_irq(orion_uart, resources, mapbase, 0xff, irq);
> -       platform_device_register(orion_uart);
> -}
> -
> -/***********************************************************************=
******
> - * UART0
> - ***********************************************************************=
*****/
> -static struct plat_serial8250_port orion_uart0_data[] =3D {
> -       {
> -               .flags          =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
> -               .iotype         =3D UPIO_MEM,
> -               .regshift       =3D 2,
> -       }, {
> -       },
> -};
> -
> -static struct resource orion_uart0_resources[2];
> -
> -static struct platform_device orion_uart0 =3D {
> -       .name                   =3D "serial8250",
> -       .id                     =3D PLAT8250_DEV_PLATFORM,
> -};
> -
> -void __init orion_uart0_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk)
> -{
> -       uart_complete(&orion_uart0, orion_uart0_data, orion_uart0_resourc=
es,
> -                     membase, mapbase, irq, clk);
> -}
> -
> -/***********************************************************************=
******
> - * UART1
> - ***********************************************************************=
*****/
> -static struct plat_serial8250_port orion_uart1_data[] =3D {
> -       {
> -               .flags          =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
> -               .iotype         =3D UPIO_MEM,
> -               .regshift       =3D 2,
> -       }, {
> -       },
> -};
> -
> -static struct resource orion_uart1_resources[2];
> -
> -static struct platform_device orion_uart1 =3D {
> -       .name                   =3D "serial8250",
> -       .id                     =3D PLAT8250_DEV_PLATFORM1,
> -};
> -
> -void __init orion_uart1_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk)
> -{
> -       uart_complete(&orion_uart1, orion_uart1_data, orion_uart1_resourc=
es,
> -                     membase, mapbase, irq, clk);
> -}
> -
> -/***********************************************************************=
******
> - * UART2
> - ***********************************************************************=
*****/
> -static struct plat_serial8250_port orion_uart2_data[] =3D {
> -       {
> -               .flags          =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
> -               .iotype         =3D UPIO_MEM,
> -               .regshift       =3D 2,
> -       }, {
> -       },
> -};
> -
> -static struct resource orion_uart2_resources[2];
> -
> -static struct platform_device orion_uart2 =3D {
> -       .name                   =3D "serial8250",
> -       .id                     =3D PLAT8250_DEV_PLATFORM2,
> -};
> -
> -void __init orion_uart2_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk)
> -{
> -       uart_complete(&orion_uart2, orion_uart2_data, orion_uart2_resourc=
es,
> -                     membase, mapbase, irq, clk);
> -}
> -
> -/***********************************************************************=
******
> - * UART3
> - ***********************************************************************=
*****/
> -static struct plat_serial8250_port orion_uart3_data[] =3D {
> -       {
> -               .flags          =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
> -               .iotype         =3D UPIO_MEM,
> -               .regshift       =3D 2,
> -       }, {
> -       },
> -};
> -
> -static struct resource orion_uart3_resources[2];
> -
> -static struct platform_device orion_uart3 =3D {
> -       .name                   =3D "serial8250",
> -       .id                     =3D 3,
> -};
> -
> -void __init orion_uart3_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk)
> -{
> -       uart_complete(&orion_uart3, orion_uart3_data, orion_uart3_resourc=
es,
> -                     membase, mapbase, irq, clk);
> -}
> -
> -/***********************************************************************=
******
> - * SoC RTC
> - ***********************************************************************=
*****/
> -static struct resource orion_rtc_resource[2];
> -
> -void __init orion_rtc_init(unsigned long mapbase,
> -                          unsigned long irq)
> -{
> -       orion_rtc_resource[0].start =3D mapbase;
> -       orion_rtc_resource[0].end =3D mapbase + SZ_32 - 1;
> -       orion_rtc_resource[0].flags =3D IORESOURCE_MEM;
> -       orion_rtc_resource[1].start =3D irq;
> -       orion_rtc_resource[1].end =3D irq;
> -       orion_rtc_resource[1].flags =3D IORESOURCE_IRQ;
> -
> -       platform_device_register_simple("rtc-mv", -1, orion_rtc_resource,=
 2);
> -}
> -
> -/***********************************************************************=
******
> - * GE
> - ***********************************************************************=
*****/
> -static __init void ge_complete(
> -       struct mv643xx_eth_shared_platform_data *orion_ge_shared_data,
> -       struct resource *orion_ge_resource, unsigned long irq,
> -       struct platform_device *orion_ge_shared,
> -       struct platform_device *orion_ge_mvmdio,
> -       struct mv643xx_eth_platform_data *eth_data,
> -       struct platform_device *orion_ge)
> -{
> -       orion_ge_resource->start =3D irq;
> -       orion_ge_resource->end =3D irq;
> -       eth_data->shared =3D orion_ge_shared;
> -       orion_ge->dev.platform_data =3D eth_data;
> -
> -       platform_device_register(orion_ge_shared);
> -       if (orion_ge_mvmdio)
> -               platform_device_register(orion_ge_mvmdio);
> -       platform_device_register(orion_ge);
> -}
> -
> -/***********************************************************************=
******
> - * GE00
> - ***********************************************************************=
*****/
> -static struct mv643xx_eth_shared_platform_data orion_ge00_shared_data;
> -
> -static struct resource orion_ge00_shared_resources[] =3D {
> -       {
> -               .name   =3D "ge00 base",
> -       },
> -};
> -
> -static struct platform_device orion_ge00_shared =3D {
> -       .name           =3D MV643XX_ETH_SHARED_NAME,
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &orion_ge00_shared_data,
> -       },
> -};
> -
> -static struct resource orion_ge_mvmdio_resources[] =3D {
> -       {
> -               .name   =3D "ge00 mvmdio base",
> -       }, {
> -               .name   =3D "ge00 mvmdio err irq",
> -       },
> -};
> -
> -static struct platform_device orion_ge_mvmdio =3D {
> -       .name           =3D "orion-mdio",
> -       .id             =3D -1,
> -};
> -
> -static struct resource orion_ge00_resources[] =3D {
> -       {
> -               .name   =3D "ge00 irq",
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct platform_device orion_ge00 =3D {
> -       .name           =3D MV643XX_ETH_NAME,
> -       .id             =3D 0,
> -       .num_resources  =3D 1,
> -       .resource       =3D orion_ge00_resources,
> -       .dev            =3D {
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq,
> -                           unsigned long irq_err,
> -                           unsigned int tx_csum_limit)
> -{
> -       fill_resources(&orion_ge00_shared, orion_ge00_shared_resources,
> -                      mapbase + 0x2000, SZ_16K - 1);
> -       fill_resources_irq(&orion_ge_mvmdio, orion_ge_mvmdio_resources,
> -                       mapbase + 0x2004, 0x84 - 1, irq_err);
> -       orion_ge00_shared_data.tx_csum_limit =3D tx_csum_limit;
> -       ge_complete(&orion_ge00_shared_data,
> -                   orion_ge00_resources, irq, &orion_ge00_shared,
> -                   &orion_ge_mvmdio,
> -                   eth_data, &orion_ge00);
> -}
> -
> -/***********************************************************************=
******
> - * GE01
> - ***********************************************************************=
*****/
> -static struct mv643xx_eth_shared_platform_data orion_ge01_shared_data;
> -
> -static struct resource orion_ge01_shared_resources[] =3D {
> -       {
> -               .name   =3D "ge01 base",
> -       }
> -};
> -
> -static struct platform_device orion_ge01_shared =3D {
> -       .name           =3D MV643XX_ETH_SHARED_NAME,
> -       .id             =3D 1,
> -       .dev            =3D {
> -               .platform_data  =3D &orion_ge01_shared_data,
> -       },
> -};
> -
> -static struct resource orion_ge01_resources[] =3D {
> -       {
> -               .name   =3D "ge01 irq",
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct platform_device orion_ge01 =3D {
> -       .name           =3D MV643XX_ETH_NAME,
> -       .id             =3D 1,
> -       .num_resources  =3D 1,
> -       .resource       =3D orion_ge01_resources,
> -       .dev            =3D {
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq,
> -                           unsigned int tx_csum_limit)
> -{
> -       fill_resources(&orion_ge01_shared, orion_ge01_shared_resources,
> -                      mapbase + 0x2000, SZ_16K - 1);
> -       orion_ge01_shared_data.tx_csum_limit =3D tx_csum_limit;
> -       ge_complete(&orion_ge01_shared_data,
> -                   orion_ge01_resources, irq, &orion_ge01_shared,
> -                   NULL,
> -                   eth_data, &orion_ge01);
> -}
> -
> -/***********************************************************************=
******
> - * GE10
> - ***********************************************************************=
*****/
> -static struct mv643xx_eth_shared_platform_data orion_ge10_shared_data;
> -
> -static struct resource orion_ge10_shared_resources[] =3D {
> -       {
> -               .name   =3D "ge10 base",
> -       }
> -};
> -
> -static struct platform_device orion_ge10_shared =3D {
> -       .name           =3D MV643XX_ETH_SHARED_NAME,
> -       .id             =3D 2,
> -       .dev            =3D {
> -               .platform_data  =3D &orion_ge10_shared_data,
> -       },
> -};
> -
> -static struct resource orion_ge10_resources[] =3D {
> -       {
> -               .name   =3D "ge10 irq",
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct platform_device orion_ge10 =3D {
> -       .name           =3D MV643XX_ETH_NAME,
> -       .id             =3D 2,
> -       .num_resources  =3D 1,
> -       .resource       =3D orion_ge10_resources,
> -       .dev            =3D {
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq)
> -{
> -       fill_resources(&orion_ge10_shared, orion_ge10_shared_resources,
> -                      mapbase + 0x2000, SZ_16K - 1);
> -       ge_complete(&orion_ge10_shared_data,
> -                   orion_ge10_resources, irq, &orion_ge10_shared,
> -                   NULL,
> -                   eth_data, &orion_ge10);
> -}
> -
> -/***********************************************************************=
******
> - * GE11
> - ***********************************************************************=
*****/
> -static struct mv643xx_eth_shared_platform_data orion_ge11_shared_data;
> -
> -static struct resource orion_ge11_shared_resources[] =3D {
> -       {
> -               .name   =3D "ge11 base",
> -       },
> -};
> -
> -static struct platform_device orion_ge11_shared =3D {
> -       .name           =3D MV643XX_ETH_SHARED_NAME,
> -       .id             =3D 3,
> -       .dev            =3D {
> -               .platform_data  =3D &orion_ge11_shared_data,
> -       },
> -};
> -
> -static struct resource orion_ge11_resources[] =3D {
> -       {
> -               .name   =3D "ge11 irq",
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct platform_device orion_ge11 =3D {
> -       .name           =3D MV643XX_ETH_NAME,
> -       .id             =3D 3,
> -       .num_resources  =3D 1,
> -       .resource       =3D orion_ge11_resources,
> -       .dev            =3D {
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq)
> -{
> -       fill_resources(&orion_ge11_shared, orion_ge11_shared_resources,
> -                      mapbase + 0x2000, SZ_16K - 1);
> -       ge_complete(&orion_ge11_shared_data,
> -                   orion_ge11_resources, irq, &orion_ge11_shared,
> -                   NULL,
> -                   eth_data, &orion_ge11);
> -}
> -
> -/***********************************************************************=
******
> - * I2C
> - ***********************************************************************=
*****/
> -static struct mv64xxx_i2c_pdata orion_i2c_pdata =3D {
> -       .freq_n         =3D 3,
> -       .timeout        =3D 1000, /* Default timeout of 1 second */
> -};
> -
> -static struct resource orion_i2c_resources[2];
> -
> -static struct platform_device orion_i2c =3D {
> -       .name           =3D MV64XXX_I2C_CTLR_NAME,
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .platform_data  =3D &orion_i2c_pdata,
> -       },
> -};
> -
> -static struct mv64xxx_i2c_pdata orion_i2c_1_pdata =3D {
> -       .freq_n         =3D 3,
> -       .timeout        =3D 1000, /* Default timeout of 1 second */
> -};
> -
> -static struct resource orion_i2c_1_resources[2];
> -
> -static struct platform_device orion_i2c_1 =3D {
> -       .name           =3D MV64XXX_I2C_CTLR_NAME,
> -       .id             =3D 1,
> -       .dev            =3D {
> -               .platform_data  =3D &orion_i2c_1_pdata,
> -       },
> -};
> -
> -void __init orion_i2c_init(unsigned long mapbase,
> -                          unsigned long irq,
> -                          unsigned long freq_m)
> -{
> -       orion_i2c_pdata.freq_m =3D freq_m;
> -       fill_resources_irq(&orion_i2c, orion_i2c_resources, mapbase,
> -                      SZ_32 - 1, irq);
> -       platform_device_register(&orion_i2c);
> -}
> -
> -void __init orion_i2c_1_init(unsigned long mapbase,
> -                            unsigned long irq,
> -                            unsigned long freq_m)
> -{
> -       orion_i2c_1_pdata.freq_m =3D freq_m;
> -       fill_resources_irq(&orion_i2c_1, orion_i2c_1_resources, mapbase,
> -                      SZ_32 - 1, irq);
> -       platform_device_register(&orion_i2c_1);
> -}
> -
> -/***********************************************************************=
******
> - * SPI
> - ***********************************************************************=
*****/
> -static struct resource orion_spi_resources;
> -
> -static struct platform_device orion_spi =3D {
> -       .name           =3D "orion_spi",
> -       .id             =3D 0,
> -};
> -
> -static struct resource orion_spi_1_resources;
> -
> -static struct platform_device orion_spi_1 =3D {
> -       .name           =3D "orion_spi",
> -       .id             =3D 1,
> -};
> -
> -/* Note: The SPI silicon core does have interrupts. However the
> - * current Linux software driver does not use interrupts. */
> -
> -void __init orion_spi_init(unsigned long mapbase)
> -{
> -       fill_resources(&orion_spi, &orion_spi_resources,
> -                      mapbase, SZ_512 - 1);
> -       platform_device_register(&orion_spi);
> -}
> -
> -void __init orion_spi_1_init(unsigned long mapbase)
> -{
> -       fill_resources(&orion_spi_1, &orion_spi_1_resources,
> -                      mapbase, SZ_512 - 1);
> -       platform_device_register(&orion_spi_1);
> -}
> -
> -/***********************************************************************=
******
> - * XOR
> - ***********************************************************************=
*****/
> -static u64 orion_xor_dmamask =3D DMA_BIT_MASK(32);
> -
> -/***********************************************************************=
******
> - * XOR0
> - ***********************************************************************=
*****/
> -static struct resource orion_xor0_shared_resources[] =3D {
> -       {
> -               .name   =3D "xor 0 low",
> -               .flags  =3D IORESOURCE_MEM,
> -       }, {
> -               .name   =3D "xor 0 high",
> -               .flags  =3D IORESOURCE_MEM,
> -       }, {
> -               .name   =3D "irq channel 0",
> -               .flags  =3D IORESOURCE_IRQ,
> -       }, {
> -               .name   =3D "irq channel 1",
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct mv_xor_channel_data orion_xor0_channels_data[2];
> -
> -static struct mv_xor_platform_data orion_xor0_pdata =3D {
> -       .channels =3D orion_xor0_channels_data,
> -};
> -
> -static struct platform_device orion_xor0_shared =3D {
> -       .name           =3D MV_XOR_NAME,
> -       .id             =3D 0,
> -       .num_resources  =3D ARRAY_SIZE(orion_xor0_shared_resources),
> -       .resource       =3D orion_xor0_shared_resources,
> -       .dev            =3D {
> -               .dma_mask               =3D &orion_xor_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -               .platform_data          =3D &orion_xor0_pdata,
> -       },
> -};
> -
> -void __init orion_xor0_init(unsigned long mapbase_low,
> -                           unsigned long mapbase_high,
> -                           unsigned long irq_0,
> -                           unsigned long irq_1)
> -{
> -       orion_xor0_shared_resources[0].start =3D mapbase_low;
> -       orion_xor0_shared_resources[0].end =3D mapbase_low + 0xff;
> -       orion_xor0_shared_resources[1].start =3D mapbase_high;
> -       orion_xor0_shared_resources[1].end =3D mapbase_high + 0xff;
> -
> -       orion_xor0_shared_resources[2].start =3D irq_0;
> -       orion_xor0_shared_resources[2].end =3D irq_0;
> -       orion_xor0_shared_resources[3].start =3D irq_1;
> -       orion_xor0_shared_resources[3].end =3D irq_1;
> -
> -       dma_cap_set(DMA_MEMCPY, orion_xor0_channels_data[0].cap_mask);
> -       dma_cap_set(DMA_XOR, orion_xor0_channels_data[0].cap_mask);
> -
> -       dma_cap_set(DMA_MEMCPY, orion_xor0_channels_data[1].cap_mask);
> -       dma_cap_set(DMA_XOR, orion_xor0_channels_data[1].cap_mask);
> -
> -       platform_device_register(&orion_xor0_shared);
> -}
> -
> -/***********************************************************************=
******
> - * XOR1
> - ***********************************************************************=
*****/
> -static struct resource orion_xor1_shared_resources[] =3D {
> -       {
> -               .name   =3D "xor 1 low",
> -               .flags  =3D IORESOURCE_MEM,
> -       }, {
> -               .name   =3D "xor 1 high",
> -               .flags  =3D IORESOURCE_MEM,
> -       }, {
> -               .name   =3D "irq channel 0",
> -               .flags  =3D IORESOURCE_IRQ,
> -       }, {
> -               .name   =3D "irq channel 1",
> -               .flags  =3D IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct mv_xor_channel_data orion_xor1_channels_data[2];
> -
> -static struct mv_xor_platform_data orion_xor1_pdata =3D {
> -       .channels =3D orion_xor1_channels_data,
> -};
> -
> -static struct platform_device orion_xor1_shared =3D {
> -       .name           =3D MV_XOR_NAME,
> -       .id             =3D 1,
> -       .num_resources  =3D ARRAY_SIZE(orion_xor1_shared_resources),
> -       .resource       =3D orion_xor1_shared_resources,
> -       .dev            =3D {
> -               .dma_mask               =3D &orion_xor_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -               .platform_data          =3D &orion_xor1_pdata,
> -       },
> -};
> -
> -void __init orion_xor1_init(unsigned long mapbase_low,
> -                           unsigned long mapbase_high,
> -                           unsigned long irq_0,
> -                           unsigned long irq_1)
> -{
> -       orion_xor1_shared_resources[0].start =3D mapbase_low;
> -       orion_xor1_shared_resources[0].end =3D mapbase_low + 0xff;
> -       orion_xor1_shared_resources[1].start =3D mapbase_high;
> -       orion_xor1_shared_resources[1].end =3D mapbase_high + 0xff;
> -
> -       orion_xor1_shared_resources[2].start =3D irq_0;
> -       orion_xor1_shared_resources[2].end =3D irq_0;
> -       orion_xor1_shared_resources[3].start =3D irq_1;
> -       orion_xor1_shared_resources[3].end =3D irq_1;
> -
> -       dma_cap_set(DMA_MEMCPY, orion_xor1_channels_data[0].cap_mask);
> -       dma_cap_set(DMA_XOR, orion_xor1_channels_data[0].cap_mask);
> -
> -       dma_cap_set(DMA_MEMCPY, orion_xor1_channels_data[1].cap_mask);
> -       dma_cap_set(DMA_XOR, orion_xor1_channels_data[1].cap_mask);
> -
> -       platform_device_register(&orion_xor1_shared);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI
> - ***********************************************************************=
*****/
> -static struct orion_ehci_data orion_ehci_data;
> -static u64 ehci_dmamask =3D DMA_BIT_MASK(32);
> -
> -
> -/***********************************************************************=
******
> - * EHCI0
> - ***********************************************************************=
*****/
> -static struct resource orion_ehci_resources[2];
> -
> -static struct platform_device orion_ehci =3D {
> -       .name           =3D "orion-ehci",
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .dma_mask               =3D &ehci_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -               .platform_data          =3D &orion_ehci_data,
> -       },
> -};
> -
> -void __init orion_ehci_init(unsigned long mapbase,
> -                           unsigned long irq,
> -                           enum orion_ehci_phy_ver phy_version)
> -{
> -       orion_ehci_data.phy_version =3D phy_version;
> -       fill_resources_irq(&orion_ehci, orion_ehci_resources, mapbase, SZ=
_4K - 1,
> -                      irq);
> -
> -       platform_device_register(&orion_ehci);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI1
> - ***********************************************************************=
*****/
> -static struct resource orion_ehci_1_resources[2];
> -
> -static struct platform_device orion_ehci_1 =3D {
> -       .name           =3D "orion-ehci",
> -       .id             =3D 1,
> -       .dev            =3D {
> -               .dma_mask               =3D &ehci_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -               .platform_data          =3D &orion_ehci_data,
> -       },
> -};
> -
> -void __init orion_ehci_1_init(unsigned long mapbase,
> -                             unsigned long irq)
> -{
> -       fill_resources_irq(&orion_ehci_1, orion_ehci_1_resources,
> -                      mapbase, SZ_4K - 1, irq);
> -
> -       platform_device_register(&orion_ehci_1);
> -}
> -
> -/***********************************************************************=
******
> - * EHCI2
> - ***********************************************************************=
*****/
> -static struct resource orion_ehci_2_resources[2];
> -
> -static struct platform_device orion_ehci_2 =3D {
> -       .name           =3D "orion-ehci",
> -       .id             =3D 2,
> -       .dev            =3D {
> -               .dma_mask               =3D &ehci_dmamask,
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -               .platform_data          =3D &orion_ehci_data,
> -       },
> -};
> -
> -void __init orion_ehci_2_init(unsigned long mapbase,
> -                             unsigned long irq)
> -{
> -       fill_resources_irq(&orion_ehci_2, orion_ehci_2_resources,
> -                      mapbase, SZ_4K - 1, irq);
> -
> -       platform_device_register(&orion_ehci_2);
> -}
> -
> -/***********************************************************************=
******
> - * SATA
> - ***********************************************************************=
*****/
> -static struct resource orion_sata_resources[2] =3D {
> -       {
> -               .name   =3D "sata base",
> -       }, {
> -               .name   =3D "sata irq",
> -       },
> -};
> -
> -static struct platform_device orion_sata =3D {
> -       .name           =3D "sata_mv",
> -       .id             =3D 0,
> -       .dev            =3D {
> -               .coherent_dma_mask      =3D DMA_BIT_MASK(32),
> -       },
> -};
> -
> -void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq)
> -{
> -       orion_sata.dev.platform_data =3D sata_data;
> -       fill_resources_irq(&orion_sata, orion_sata_resources,
> -                      mapbase, 0x5000 - 1, irq);
> -
> -       platform_device_register(&orion_sata);
> -}
> -
> -/***********************************************************************=
******
> - * Cryptographic Engines and Security Accelerator (CESA)
> - ***********************************************************************=
*****/
> -static struct resource orion_crypto_resources[] =3D {
> -       {
> -               .name   =3D "regs",
> -       }, {
> -               .name   =3D "crypto interrupt",
> -       }, {
> -               .name   =3D "sram",
> -               .flags  =3D IORESOURCE_MEM,
> -       },
> -};
> -
> -static struct platform_device orion_crypto =3D {
> -       .name           =3D "mv_crypto",
> -       .id             =3D -1,
> -};
> -
> -void __init orion_crypto_init(unsigned long mapbase,
> -                             unsigned long srambase,
> -                             unsigned long sram_size,
> -                             unsigned long irq)
> -{
> -       fill_resources_irq(&orion_crypto, orion_crypto_resources,
> -                      mapbase, 0xffff, irq);
> -       orion_crypto.num_resources =3D 3;
> -       orion_crypto_resources[2].start =3D srambase;
> -       orion_crypto_resources[2].end =3D srambase + sram_size - 1;
> -
> -       platform_device_register(&orion_crypto);
> -}
> diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-=
orion/include/plat/addr-map.h
> deleted file mode 100644
> index b76c06569fe5..000000000000
> --- a/arch/arm/plat-orion/include/plat/addr-map.h
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - * arch/arm/plat-orion/include/plat/addr-map.h
> - *
> - * Marvell Orion SoC address map handling.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __PLAT_ADDR_MAP_H
> -#define __PLAT_ADDR_MAP_H
> -
> -extern struct mbus_dram_target_info orion_mbus_dram_info;
> -
> -struct orion_addr_map_cfg {
> -       const int num_wins;     /* Total number of windows */
> -       const int remappable_wins;
> -       void __iomem *bridge_virt_base;
> -       int hw_io_coherency;
> -
> -       /* If NULL, the default cpu_win_can_remap will be used, using
> -          the value in remappable_wins */
> -       int (*cpu_win_can_remap) (const struct orion_addr_map_cfg *cfg,
> -                                 const int win);
> -       /* If NULL, the default win_cfg_base will be used, using the
> -          value in bridge_virt_base */
> -       void __iomem *(*win_cfg_base) (const struct orion_addr_map_cfg *c=
fg,
> -                                const int win);
> -};
> -
> -/*
> - * Information needed to setup one address mapping.
> - */
> -struct orion_addr_map_info {
> -       const int win;
> -       const u32 base;
> -       const u32 size;
> -       const u8 target;
> -       const u8 attr;
> -       const int remap;
> -};
> -
> -void __init orion_config_wins(struct orion_addr_map_cfg *cfg,
> -                             const struct orion_addr_map_info *info);
> -
> -void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
> -                               const int win, const u32 base,
> -                               const u32 size, const u8 target,
> -                               const u8 attr, const int remap);
> -
> -void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg =
*cfg,
> -                                       const void __iomem *ddr_window_cp=
u_base);
> -#endif
> diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-or=
ion/include/plat/common.h
> deleted file mode 100644
> index d2aad95d20cb..000000000000
> --- a/arch/arm/plat-orion/include/plat/common.h
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -/*
> - * arch/arm/plat-orion/include/plat/common.h
> - *
> - * Marvell Orion SoC common setup code used by different mach-/common.c
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __PLAT_COMMON_H
> -#include <linux/mv643xx_eth.h>
> -#include <linux/platform_data/usb-ehci-orion.h>
> -
> -struct mv_sata_platform_data;
> -
> -void __init orion_uart0_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk);
> -
> -void __init orion_uart1_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk);
> -
> -void __init orion_uart2_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk);
> -
> -void __init orion_uart3_init(void __iomem *membase,
> -                            resource_size_t mapbase,
> -                            unsigned int irq,
> -                            struct clk *clk);
> -
> -void __init orion_rtc_init(unsigned long mapbase,
> -                          unsigned long irq);
> -
> -void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq,
> -                           unsigned long irq_err,
> -                           unsigned int tx_csum_limit);
> -
> -void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq,
> -                           unsigned int tx_csum_limit);
> -
> -void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq);
> -
> -void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq);
> -
> -void __init orion_i2c_init(unsigned long mapbase,
> -                          unsigned long irq,
> -                          unsigned long freq_m);
> -
> -void __init orion_i2c_1_init(unsigned long mapbase,
> -                            unsigned long irq,
> -                            unsigned long freq_m);
> -
> -void __init orion_spi_init(unsigned long mapbase);
> -
> -void __init orion_spi_1_init(unsigned long mapbase);
> -
> -void __init orion_xor0_init(unsigned long mapbase_low,
> -                           unsigned long mapbase_high,
> -                           unsigned long irq_0,
> -                           unsigned long irq_1);
> -
> -void __init orion_xor1_init(unsigned long mapbase_low,
> -                           unsigned long mapbase_high,
> -                           unsigned long irq_0,
> -                           unsigned long irq_1);
> -
> -void __init orion_ehci_init(unsigned long mapbase,
> -                           unsigned long irq,
> -                           enum orion_ehci_phy_ver phy_version);
> -
> -void __init orion_ehci_1_init(unsigned long mapbase,
> -                             unsigned long irq);
> -
> -void __init orion_ehci_2_init(unsigned long mapbase,
> -                             unsigned long irq);
> -
> -void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
> -                           unsigned long mapbase,
> -                           unsigned long irq);
> -
> -void __init orion_crypto_init(unsigned long mapbase,
> -                             unsigned long srambase,
> -                             unsigned long sram_size,
> -                             unsigned long irq);
> -
> -void __init orion_clkdev_add(const char *con_id, const char *dev_id,
> -                            struct clk *clk);
> -
> -void __init orion_clkdev_init(struct clk *tclk);
> -#endif
> diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/plat-orio=
n/include/plat/time.h
> deleted file mode 100644
> index 07527e417c62..000000000000
> --- a/arch/arm/plat-orion/include/plat/time.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/*
> - * arch/arm/plat-orion/include/plat/time.h
> - *
> - * Marvell Orion SoC time handling.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __PLAT_TIME_H
> -#define __PLAT_TIME_H
> -
> -void orion_time_set_base(void __iomem *timer_base);
> -
> -void orion_time_init(void __iomem *bridge_base, u32 bridge_timer1_clr_ma=
sk,
> -                    unsigned int irq, unsigned int tclk);
> -
> -
> -#endif
> diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
> index 8b8c06d2e9c4..e817f20409c4 100644
> --- a/arch/arm/plat-orion/pcie.c
> +++ b/arch/arm/plat-orion/pcie.c
> @@ -13,7 +13,6 @@
>  #include <linux/mbus.h>
>  #include <asm/mach/pci.h>
>  #include <plat/pcie.h>
> -#include <plat/addr-map.h>
>  #include <linux/delay.h>
>
>  /*
> diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
> deleted file mode 100644
> index 509d4824dc1c..000000000000
> --- a/arch/arm/plat-orion/time.c
> +++ /dev/null
> @@ -1,238 +0,0 @@
> -/*
> - * arch/arm/plat-orion/time.c
> - *
> - * Marvell Orion SoC timer handling.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - *
> - * Timer 0 is used as free-running clocksource, while timer 1 is
> - * used as clock_event_device.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/timer.h>
> -#include <linux/clockchips.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/sched_clock.h>
> -#include <plat/time.h>
> -#include <asm/delay.h>
> -
> -/*
> - * MBus bridge block registers.
> - */
> -#define BRIDGE_CAUSE_OFF       0x0110
> -#define BRIDGE_MASK_OFF                0x0114
> -#define  BRIDGE_INT_TIMER0      0x0002
> -#define  BRIDGE_INT_TIMER1      0x0004
> -
> -
> -/*
> - * Timer block registers.
> - */
> -#define TIMER_CTRL_OFF         0x0000
> -#define  TIMER0_EN              0x0001
> -#define  TIMER0_RELOAD_EN       0x0002
> -#define  TIMER1_EN              0x0004
> -#define  TIMER1_RELOAD_EN       0x0008
> -#define TIMER0_RELOAD_OFF      0x0010
> -#define TIMER0_VAL_OFF         0x0014
> -#define TIMER1_RELOAD_OFF      0x0018
> -#define TIMER1_VAL_OFF         0x001c
> -
> -
> -/*
> - * SoC-specific data.
> - */
> -static void __iomem *bridge_base;
> -static u32 bridge_timer1_clr_mask;
> -static void __iomem *timer_base;
> -
> -
> -/*
> - * Number of timer ticks per jiffy.
> - */
> -static u32 ticks_per_jiffy;
> -
> -
> -/*
> - * Orion's sched_clock implementation. It has a resolution of
> - * at least 7.5ns (133MHz TCLK).
> - */
> -
> -static u64 notrace orion_read_sched_clock(void)
> -{
> -       return ~readl(timer_base + TIMER0_VAL_OFF);
> -}
> -
> -/*
> - * Clockevent handling.
> - */
> -static int
> -orion_clkevt_next_event(unsigned long delta, struct clock_event_device *=
dev)
> -{
> -       unsigned long flags;
> -       u32 u;
> -
> -       if (delta =3D=3D 0)
> -               return -ETIME;
> -
> -       local_irq_save(flags);
> -
> -       /*
> -        * Clear and enable clockevent timer interrupt.
> -        */
> -       writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
> -
> -       u =3D readl(bridge_base + BRIDGE_MASK_OFF);
> -       u |=3D BRIDGE_INT_TIMER1;
> -       writel(u, bridge_base + BRIDGE_MASK_OFF);
> -
> -       /*
> -        * Setup new clockevent timer value.
> -        */
> -       writel(delta, timer_base + TIMER1_VAL_OFF);
> -
> -       /*
> -        * Enable the timer.
> -        */
> -       u =3D readl(timer_base + TIMER_CTRL_OFF);
> -       u =3D (u & ~TIMER1_RELOAD_EN) | TIMER1_EN;
> -       writel(u, timer_base + TIMER_CTRL_OFF);
> -
> -       local_irq_restore(flags);
> -
> -       return 0;
> -}
> -
> -static int orion_clkevt_shutdown(struct clock_event_device *evt)
> -{
> -       unsigned long flags;
> -       u32 u;
> -
> -       local_irq_save(flags);
> -
> -       /* Disable timer */
> -       u =3D readl(timer_base + TIMER_CTRL_OFF);
> -       writel(u & ~TIMER1_EN, timer_base + TIMER_CTRL_OFF);
> -
> -       /* Disable timer interrupt */
> -       u =3D readl(bridge_base + BRIDGE_MASK_OFF);
> -       writel(u & ~BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
> -
> -       /* ACK pending timer interrupt */
> -       writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
> -
> -       local_irq_restore(flags);
> -
> -       return 0;
> -}
> -
> -static int orion_clkevt_set_periodic(struct clock_event_device *evt)
> -{
> -       unsigned long flags;
> -       u32 u;
> -
> -       local_irq_save(flags);
> -
> -       /* Setup timer to fire at 1/HZ intervals */
> -       writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD_OFF);
> -       writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL_OFF);
> -
> -       /* Enable timer interrupt */
> -       u =3D readl(bridge_base + BRIDGE_MASK_OFF);
> -       writel(u | BRIDGE_INT_TIMER1, bridge_base + BRIDGE_MASK_OFF);
> -
> -       /* Enable timer */
> -       u =3D readl(timer_base + TIMER_CTRL_OFF);
> -       writel(u | TIMER1_EN | TIMER1_RELOAD_EN, timer_base + TIMER_CTRL_=
OFF);
> -
> -       local_irq_restore(flags);
> -
> -       return 0;
> -}
> -
> -static struct clock_event_device orion_clkevt =3D {
> -       .name                   =3D "orion_tick",
> -       .features               =3D CLOCK_EVT_FEAT_ONESHOT |
> -                                 CLOCK_EVT_FEAT_PERIODIC,
> -       .rating                 =3D 300,
> -       .set_next_event         =3D orion_clkevt_next_event,
> -       .set_state_shutdown     =3D orion_clkevt_shutdown,
> -       .set_state_periodic     =3D orion_clkevt_set_periodic,
> -       .set_state_oneshot      =3D orion_clkevt_shutdown,
> -       .tick_resume            =3D orion_clkevt_shutdown,
> -};
> -
> -static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
> -{
> -       /*
> -        * ACK timer interrupt and call event handler.
> -        */
> -       writel(bridge_timer1_clr_mask, bridge_base + BRIDGE_CAUSE_OFF);
> -       orion_clkevt.event_handler(&orion_clkevt);
> -
> -       return IRQ_HANDLED;
> -}
> -
> -void __init
> -orion_time_set_base(void __iomem *_timer_base)
> -{
> -       timer_base =3D _timer_base;
> -}
> -
> -static unsigned long orion_delay_timer_read(void)
> -{
> -       return ~readl(timer_base + TIMER0_VAL_OFF);
> -}
> -
> -static struct delay_timer orion_delay_timer =3D {
> -       .read_current_timer =3D orion_delay_timer_read,
> -};
> -
> -void __init
> -orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
> -               unsigned int irq, unsigned int tclk)
> -{
> -       u32 u;
> -
> -       /*
> -        * Set SoC-specific data.
> -        */
> -       bridge_base =3D _bridge_base;
> -       bridge_timer1_clr_mask =3D _bridge_timer1_clr_mask;
> -
> -       ticks_per_jiffy =3D (tclk + HZ/2) / HZ;
> -
> -       orion_delay_timer.freq =3D tclk;
> -       register_current_timer_delay(&orion_delay_timer);
> -
> -       /*
> -        * Set scale and timer for sched_clock.
> -        */
> -       sched_clock_register(orion_read_sched_clock, 32, tclk);
> -
> -       /*
> -        * Setup free-running clocksource timer (interrupts
> -        * disabled).
> -        */
> -       writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
> -       writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
> -       u =3D readl(bridge_base + BRIDGE_MASK_OFF);
> -       writel(u & ~BRIDGE_INT_TIMER0, bridge_base + BRIDGE_MASK_OFF);
> -       u =3D readl(timer_base + TIMER_CTRL_OFF);
> -       writel(u | TIMER0_EN | TIMER0_RELOAD_EN, timer_base + TIMER_CTRL_=
OFF);
> -       clocksource_mmio_init(timer_base + TIMER0_VAL_OFF, "orion_clockso=
urce",
> -               tclk, 300, 32, clocksource_mmio_readl_down);
> -
> -       /*
> -        * Setup clockevent timer (interrupt-driven).
> -        */
> -       if (request_irq(irq, orion_timer_interrupt, IRQF_TIMER, "orion_ti=
ck",
> -                       NULL))
> -               pr_err("Failed to request irq %u (orion_tick)\n", irq);
> -       orion_clkevt.cpumask =3D cpumask_of(0);
> -       clockevents_config_and_register(&orion_clkevt, tclk, 1, 0xfffffff=
e);
> -}
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 28ca856ecc75..434cce3efd96 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -471,8 +471,7 @@ config SATA_HIGHBANK
>
>  config SATA_MV
>         tristate "Marvell SATA support"
> -       depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
> -                  ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
> +       depends on PCI || ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
>         select GENERIC_PHY
>         select SATA_HOST
>         help
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4f060d3e5636..d06903635335 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -330,7 +330,7 @@ config MMC_SDHCI_ESDHC_IMX
>
>  config MMC_SDHCI_DOVE
>         tristate "SDHCI support on Marvell's Dove SoC"
> -       depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
> +       depends on MACH_DOVE || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index d246bbe37948..7e550c474b7a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -197,7 +197,7 @@ config PCI_LOONGSON
>
>  config PCI_MVEBU
>         tristate "Marvell EBU PCIe controller"
> -       depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> +       depends on ARCH_MVEBU || COMPILE_TEST
>         depends on MVEBU_MBUS
>         depends on ARM
>         depends on OF
> diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> index bccd72dccb77..c29d2d28ae55 100644
> --- a/drivers/phy/marvell/Kconfig
> +++ b/drivers/phy/marvell/Kconfig
> @@ -77,7 +77,7 @@ config PHY_MVEBU_CP110_UTMI
>
>  config PHY_MVEBU_SATA
>         def_bool y
> -       depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
> +       depends on MACH_DOVE || MACH_KIRKWOOD
>         depends on OF
>         select GENERIC_PHY
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 55ffee3d75ce..5cb6cdfe6015 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1703,7 +1703,7 @@ config RTC_DRV_STARFIRE
>
>  config RTC_DRV_MV
>         tristate "Marvell SoC RTC"
> -       depends on ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
> +       depends on ARCH_MVEBU || COMPILE_TEST
>         help
>           If you say yes here you will get support for the in-chip RTC
>           that can be found in some of Marvell's SoC devices, such as
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index c9e689080ceb..6411b96d584c 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -9,7 +9,6 @@ obj-$(CONFIG_ARCH_AT91)         +=3D atmel/
>  obj-y                          +=3D bcm/
>  obj-$(CONFIG_ARCH_CANAAN)      +=3D canaan/
>  obj-$(CONFIG_EP93XX_SOC)        +=3D cirrus/
> -obj-$(CONFIG_ARCH_DOVE)                +=3D dove/
>  obj-$(CONFIG_MACH_DOVE)                +=3D dove/
>  obj-y                          +=3D fsl/
>  obj-y                          +=3D fujitsu/
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 810eeccedfba..8cef9b658191 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -391,7 +391,7 @@ config KIRKWOOD_THERMAL
>
>  config DOVE_THERMAL
>         tristate "Temperature sensor on Marvell Dove SoCs"
> -       depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
> +       depends on MACH_DOVE || COMPILE_TEST
>         depends on HAS_IOMEM
>         depends on OF
>         help
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0ab0dcc6d27d..d83bfb189705 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -690,7 +690,7 @@ config K3_RTI_WATCHDOG
>
>  config ORION_WATCHDOG
>         tristate "Orion watchdog"
> -       depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU |=
| COMPILE_TEST
> +       depends on ARCH_ORION5X || MACH_DOVE || ARCH_MVEBU || COMPILE_TES=
T
>         depends on ARM
>         select WATCHDOG_CORE
>         help
> diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
> index 924072e402c8..d59c5bb0b391 100644
> --- a/sound/soc/kirkwood/Kconfig
> +++ b/sound/soc/kirkwood/Kconfig
> @@ -3,7 +3,7 @@ menu "Kirkwood"
>
>  config SND_KIRKWOOD_SOC
>         tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
> -       depends on ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
> +       depends on ARCH_MVEBU || COMPILE_TEST
>         help
>           Say Y or M if you want to add support for codecs attached to
>           the Kirkwood I2S interface. You will also need to select the

> --
> 2.53.0
>
