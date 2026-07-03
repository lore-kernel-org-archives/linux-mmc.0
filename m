Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2C33439A
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107908; cv=none; b=JMjgL6GRP6rJdCIoj9MpPs4P9D3hUfA5FJDnMZ4TbdjaVcC6reuR95SkqnuWbbPWkXlFeAZFZ6sH++WO1pS5corAQsuD1Jv7RKmQ6H/LdXi8bKlc3mpotpKh5Wo9RXYEPOrsBkgMTbCmjyeFFhwbKCZYr7ebSJgcChsPvw+I7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107908; c=relaxed/simple;
	bh=YCS3/Dpz0Fo4USHwvmuADURVgak+6qLUsiuuXpl8TrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDc8NLGrcto956vYp50gfTcmjpQ/acmUkBSoqki1fu5ajYA0c7aLY1ENDfDSMGKzTE4BhGF9JW9IPkxL7oZnLqaIzJPQiu1lr+4s2EB51290/ADzXlq4GPJQUoE7h/9iySu2hsS+2Z0HtoWe8WHkrqxCJH1xuXi0COxcFIjR6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4lGk2E5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OIH22mIu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4lGk2E5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OIH22mIu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hj3YK676960
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wV2jvG58Lj5
	Bs1ZlVjSXOSGXHXpRQv1KBOONp4Qs7fI=; b=I4lGk2E5mZ7Li8Ro5GPM2C07N9d
	b+pOUkiWJ+kt9dhiSiaU2EHDkbsvQyYnnmoK13NsOVmKzOUfpseFpxEEZMgop1sf
	V4Us6vaVFq4s2wpZA40NshGb0oPMAvVKkWnl+29Iw4tnYF6iVledRkC4P6hYTIWJ
	aIU87KPTR3fAYuK3eRfa+Jysa7aefGL/V7kSoHfrq7ZA5YmkgmN3YgJtDbXU04e5
	XDiArJTWpNNC4h/1ik6zSYXTca60q5JuJiycl0z2+a6YO2+ERe+AcUdLChE29gz3
	UssOdQ8699J8ukEPuMOk83jonBFYC42ozd39SRdIY6OCsowsNfKJ65bCjNw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1h2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:45:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so1710246a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107904; x=1783712704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV2jvG58Lj5Bs1ZlVjSXOSGXHXpRQv1KBOONp4Qs7fI=;
        b=OIH22mIuwMHlNCeo0sWlRcfV9lk4xnVPY5ebLknveojI3M0i/jXXHO2wlizKUamVYl
         Lm92B0Gxv+EuGpy+sonhMSptMI90aJ6WKvIRcGBjwE5HGD9DSbWA70tlMweAyLr96/dT
         zvmNPIIiYQG6IjqGlh6tkzH751WbKDTQsHLIr/WIKjga84aKhWYBsu/pAXfYpRGMXHv9
         Tw4uDySOXgAHQHMxX5FTsmV2J3Spiu+scI+ZVInO8pcj7m7dgPaAxbAfNNUu6ItHtZ2l
         LW2veo0jCKuGXFnYdOIsCJvMr8/cNmkNvji7GOtsVNoi+gA1fKYrLdFma1gsrRxV2aim
         puSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107904; x=1783712704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV2jvG58Lj5Bs1ZlVjSXOSGXHXpRQv1KBOONp4Qs7fI=;
        b=Eis4Grd31v2m5p9xaaM+3rJMgpAnEPJGEG4qDV7snpnizFNezt0IcuorPrred8Xmdh
         ye6Fr9vzHjXPetLp9Kb7Bysrj1gxZ86cpeUSKtx9nMsm/+HUeDYW8g6nGitgYthpfYmq
         CGIAoM+unaCIHo9eBfUPh+Z03N1bGwc7f34QyDx0KOPUPUbgS3JiO8Ir9ktVsP5HU8+4
         gDcWH9l8puTP4zbu3lc2R0T0NwbnHWD31qqpi+owFWXiM4T+ELK0FLUJhMjykni3ukFD
         6k2dT7Iezc5A8SFLw+GMZqk6L2Et8VJEUOsoefszgnthiNUS+1zC14calFPCdhdxr2ob
         zrRg==
X-Forwarded-Encrypted: i=1; AHgh+RqUzn4zCWGKp3UaSoF5DlooWA349002GEo6QWKHCK8Aa3C4XEYjKC6Ld+F2if0skJaiwqADwu+Q9jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzQuPY42S2lcbeo84/+JjhrY1iTEjp+kuzkxLQm+7phz70cZ2
	ns1yUVXobB8Goj9/oVYAQGEHH5ELy+z97JInyvEL+7LGpDFWyw2/Im3k2mnHomgFOAExUy7xjGH
	uPIb2z5xhYGQ5RtIIGJIt9n4JPAuEMJ1caKKuz8J9weFsLn6aPFV7C+FjRczV1T4=
X-Gm-Gg: AfdE7ckO67LiWZEek02FgxfqYyRVF0sAvbxCLWl8NyBVL21ZdyAjXEs8jt+5C0stqjq
	rkiJZ22pJ0gBoMY5IpeRD9NYgJlTRG2oFBfAWHEZ2D4x+UWdzjaoXXoFceIRlS599fqXFJkTgeJ
	+YkN51rRODAR26M17uzlRbFBBDaOizT6w4y3iaA8ofEIm+ynWq7J3Z24IFJ7IUfrYT4IWkoMeGa
	I0K4dNVYS2CBEZhTTyTUA1r0dbAL427HosQMJV6V4ZKqG+kYhTuRHZQgSBNpLz2lzUYRZTq1nZf
	KkkrjonjNfrCjjiy4W6BGfGPNmCl+0wJdZBhCQtuzhc7ii8VoErglbAdJ+4tp4ZMqc3JV1/QfkB
	zQ+jdqP3nGM9bVc5/KeIiEEI++tfM5LscjfBWlg==
X-Received: by 2002:a17:90b:1d51:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-3835a16be4bmr383573a91.16.1783107903380;
        Fri, 03 Jul 2026 12:45:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1d51:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-3835a16be4bmr383511a91.16.1783107902725;
        Fri, 03 Jul 2026 12:45:02 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:45:02 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 14/42] memory: tegra210-emc: Use devm_of_reserved_mem_device_init_by_name()
Date: Sat,  4 Jul 2026 01:08:27 +0530
Message-ID: <20260703193855.110619-15-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX/rxJjHcqPIuA
 mN4uvgHhYkMleDje56koskpV0nScHWlqx9+cgof/WzELtbdCBp1tqKTphDD7PaNlHbpSbhxs/Wa
 3svQXh0gCXd9VwLbIPfxrUTfEeHQm/M=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a481140 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=0pCqoRa_c3HA8O-7yLQA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: EB6uzS3VtRCcszEjyx6_KfZEiuhXVLQH
X-Proofpoint-GUID: EB6uzS3VtRCcszEjyx6_KfZEiuhXVLQH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX2bzTSIqd9cH+
 mZhCevQgpgQLd9dvM4UlaSQuArNW8qcqPwnCYpfyG4Pl0q+olSFgu2u8RQaJb4C0H/agXtdpqqo
 QGX/PAdWDhQ3gkn05Ap5s2hyKoAK/ojc5GrM8d95FI/BGJk+n+JXhFVqanSx7tNcBGR4iK5EsR+
 GwLtAZr99Kkfutwzuy49mzLyGqQ6KZFyOa2NQcvcfBPGUBxLrC/gLJ32Qr90H67d3PXuAXZMJTg
 zeWQXs/kM7v65v/XBRgIdadgiKt9mx6Ywv2e5rDIQaTDFiUCXelc8D4S2Haz6V/4H1E9uMrgkAe
 AWYRUgeZ60DWjpeUBs/VC4hphQznJtcBJI5LscfVyjIkLADijxRUynaMygN24O/3l0WNOf1RQ+Q
 pqdOQ0QI+Mny5jOwusrBNfZge97PrSD7gGC1TzCnjhBT70Ni/eSdEko4NhkCZ9emw1A4rFQs0Rk
 rXo1Xgz3YAh1HZKr8+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Switch to the new devm_of_reserved_mem_device_init_by_name() for both
the nominal and derated reserved memory regions so they are released
automatically on probe failure or device removal.

All six goto release paths in the probe function precede clock attach
and debugfs initialization, so they become plain return statements.
The release: label and its explicit of_reserved_mem_device_release()
calls in both the probe error path and tegra210_emc_remove() are
removed.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/memory/tegra/tegra210-emc-core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index e8d4cd8fdec2..07c7654dac63 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -1847,16 +1847,16 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 	np = pdev->dev.of_node;
 
 	/* attach to the nominal and (optional) derated tables */
-	err = of_reserved_mem_device_init_by_name(emc->dev, np, "nominal");
+	err = devm_of_reserved_mem_device_init_by_name(emc->dev, np, "nominal");
 	if (err < 0) {
 		dev_err(emc->dev, "failed to get nominal EMC table: %d\n", err);
 		return err;
 	}
 
-	err = of_reserved_mem_device_init_by_name(emc->dev, np, "derated");
+	err = devm_of_reserved_mem_device_init_by_name(emc->dev, np, "derated");
 	if (err < 0 && err != -ENODEV) {
 		dev_err(emc->dev, "failed to get derated EMC table: %d\n", err);
-		goto release;
+		return err;
 	}
 
 	/* validate the tables */
@@ -1864,14 +1864,14 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 		err = tegra210_emc_validate_timings(emc, emc->nominal,
 						    emc->num_timings);
 		if (err < 0)
-			goto release;
+			return err;
 	}
 
 	if (emc->derated) {
 		err = tegra210_emc_validate_timings(emc, emc->derated,
 						    emc->num_timings);
 		if (err < 0)
-			goto release;
+			return err;
 	}
 
 	/* default to the nominal table */
@@ -1891,7 +1891,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 		dev_err(emc->dev, "no EMC table entry found for %lu kHz\n",
 			current_rate);
 		err = -ENOENT;
-		goto release;
+		return err;
 	}
 
 	/* pick a compatible clock change sequence for the EMC table */
@@ -1909,7 +1909,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "sequence %u not supported\n",
 			emc->timings[0].revision);
 		err = -ENOTSUPP;
-		goto release;
+		return err;
 	}
 
 	emc->offsets = &tegra210_emc_table_register_offsets;
@@ -1924,7 +1924,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 					     GFP_KERNEL);
 	if (!emc->provider.configs) {
 		err = -ENOMEM;
-		goto release;
+		return err;
 	}
 
 	emc->provider.num_configs = emc->num_timings;
@@ -1949,7 +1949,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 	err = tegra210_clk_emc_attach(emc->clk, &emc->provider);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to attach to EMC clock: %d\n", err);
-		goto release;
+		return err;
 	}
 
 	emc->clkchange_delay = 100;
@@ -1979,8 +1979,6 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 detach:
 	debugfs_remove_recursive(emc->debugfs.root);
 	tegra210_clk_emc_detach(emc->clk);
-release:
-	of_reserved_mem_device_release(emc->dev);
 
 	return err;
 }
@@ -1991,7 +1989,6 @@ static void tegra210_emc_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(emc->debugfs.root);
 	tegra210_clk_emc_detach(emc->clk);
-	of_reserved_mem_device_release(emc->dev);
 }
 
 static int __maybe_unused tegra210_emc_suspend(struct device *dev)
-- 
2.53.0

