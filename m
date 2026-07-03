Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4D3264FB
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107618; cv=none; b=ETbI8fA6t10VPWJXcwYJzoNbpsltW++sRRJm5koayUEhkbIWqT4sMJCza4iiq2C0PbV5RDX5D7YJAZExZji3SxrqiBr6v5AQyoksWKeIKo8xFAE138pT85mBYtr9xWyzgTOw8u8SvLe1Mbqky3oBYyu1WFFMEWsuQxq9Yv9fAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107618; c=relaxed/simple;
	bh=oHFB4sL3tHNSQdz1blCjwGW5qxp8LON4aK4OWW8RoPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/iDX97XOQ31hBFg2SZyX99j1HdJr+YYhJea0dgOd53Tq3thFcDK8rwYNnwN1Nh44T8WQ2SOBh3bU3MA8TO/A9NT8BjgkSctutBM2zKljgh0BJ1KB8sD8ob9znaOP0ME0s35vuBbwBLs5e4NLKmKFHQnMuPsrhxaukMjbUTqo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HipLHZTm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FyA7qn+u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HipLHZTm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FyA7qn+u"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiIHb683668
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PGH0Mfb9t3d
	kT8UvMf5f1wosC3eQeF337EZxodGa2xo=; b=HipLHZTmLwrBQObeVsOGWExITfp
	t7/tVWx4vzKDtDPxgNwrOMMLEYbY4ozBpTauLC1kSTV/W7k1Qm0e12vRO+ogANBW
	NW0APmhU3sAdU2NrCqlWIoHmD0kU4SQGq4ljc6YwuMSM7GFhHObmCpJ+/+rhnKsQ
	INKlcMzloIbYPjrnEN/lLIpHGyWDH5yPXXSi8+KcBgoraO6K/MnRfB3UUkLILky6
	qTPqH4OVJXMwBZsrvWtdNjSsexZaz22Q5jADDCPONMxS+LjIGY3qz0KpGGSr3YaR
	wcrE60nfHX13IMBNYdT4V8pqcZ2+pD+AyngKR10muMKnOdEdCQYuLKpAovQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5brq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:40:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3810e5c5871so1379521a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107615; x=1783712415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGH0Mfb9t3dkT8UvMf5f1wosC3eQeF337EZxodGa2xo=;
        b=FyA7qn+u5syLfm1jtWZJcRPfjQFqkOSH5dVc0BYmQQ5ytE14Zm3fEHbasIM4WTwmYo
         KPDDDWzeoG0+wkKsL8dopXkNslLSyYMPJBo4iriq1DQAAgKDnZEDSJTBMrsaVqrxxiCT
         C0RJmVF/6UQzPDpHv9TxPvVZae1PQAULtEmx8RHjDkkGVeDwgZMdy3QxNfhXTfXODbp4
         l4X+z4y8p6u5RBFQ4VJzSayluQrNcZ7K8Wsc309qWYm0/yCuwi95NJ8vi1cTTAMcYbgC
         pxhYwOwUVw0QFyg7ukIQsTG6ePfGMt6fGw/UuG+vV4NvASTL9EjlaYV6yVZaU8XOwwkN
         X2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107615; x=1783712415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGH0Mfb9t3dkT8UvMf5f1wosC3eQeF337EZxodGa2xo=;
        b=T8b8PFiZclIQ/D8/aWUFbWNpEyPimFBtOJ0Tqwq3qvXV90EW0Bm3YLrecqgke1FX7c
         7pYzpIvqcBsCEGaudEG97x5SIIN4iLKxxe5Kh/mMRsVW34b0/PxcFvB5oSvA3chtaAPO
         ZloaV76l4ygKsY8xYOLqDu5tuqNCgD8xEXqLZVDCebhkYLJ1ltDcdY2hjFuMGebqUvqd
         m5RH3/e7tnic1zl12xVcQ97AwIxVTAlLk3Ej3aJ/jKHTBcs6HjK/o2RcfNl8ZW2Le4N3
         P3XHuC2DLtbs1jCAkSgd7nmg6I/mN2yA4de86E9b3xYST1gimjQCox2AokfFMn94H73s
         0p5A==
X-Forwarded-Encrypted: i=1; AHgh+RqOe48D0iNXAdegZXWxtJiQBqEXV0N8hRjwqaBkvNXFdpFuJM+vnObaL3qj+tmHi5HKqhfwKQo46c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXmF1jCdQEn91a0e8Ew6EU1jCdHEDPMum1pgQvNW5UW5iyUrH
	MWicOIVL85/UOyuyg0wKrbGQJn2Q76Y9nImLcC4F4+z2EAjlihkmfg64tDickUoeVXjHa7wC3Nr
	QA1MkTFhIDluWwvrE2mddA1DV7BH1xsGYhCm0fXF3qkYnuuNhQ8HIUw9laKFpMQk=
X-Gm-Gg: AfdE7cnP1wZ2CyW/Q9mBfs+B/052MzHkH7y9LPK/EpGT+6eBNGsPPgBrA3+p/UqiOk9
	/Jc1cgcUWkf98lYsxfpW3/y6XGInrwh7SSccEAx9SZ5YOaceeoaEUC8a/5qyAfMxQZTw2z3EXDL
	Hg5FtolofdpnGObB8qE5RMl1S5LjOrgyRNJ5y1Dd7jd2QjlelOObt8MB6HB5Tlv+x9V9HYUVT5g
	oj6bzWcHhRJgQqAnjLROqVd3C1/cgMORZMUMUuam1iIumPPSNp03m6PSDfej6Dl6hO40DzrmmdA
	deMlHMrSYBuy6cEkgy9msBcJ/wEECtOL4CYW3f4bM5Ce1IP1GTRl2diqK/tAnGzg1wvqF/luwVv
	1WSai0XqqCP2Fg45d+Y6+O9Kfm1+FauExR8pUWA==
X-Received: by 2002:a17:90b:4fd1:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-3829f0054e1mr764382a91.21.1783107614344;
        Fri, 03 Jul 2026 12:40:14 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd1:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-3829f0054e1mr764330a91.21.1783107613641;
        Fri, 03 Jul 2026 12:40:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:40:13 -0700 (PDT)
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
Subject: [PATCH 02/42] of: reserved_mem: Add devm_of_reserved_mem_device_init_by_name()
Date: Sat,  4 Jul 2026 01:08:15 +0530
Message-ID: <20260703193855.110619-3-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX860mg6w8Wxqi
 73fR17ysqAqxbEwgswcJyXPFddbeF/+rukVdwg6i5lWC3pTnhtGnsVoDpgaeULH84pWqhX9MbU6
 wWZTB61XQGMp8I9TAzNQpr4ND7yhkzQ=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a48101f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=K3bnyJ_z4bF7bLuR74EA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 0oWyKZj_jQhrgQOwuiEas3sa9ExkyLK6
X-Proofpoint-GUID: 0oWyKZj_jQhrgQOwuiEas3sa9ExkyLK6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXyNb8AyNay2a8
 IJS1mXwG7k+luS7PZQ+ydIqqDwwpiPyu8zJo5u5MNkzbhsaBN7DuUtQHf7lGm2RHsoPcNmOQ8Yd
 r/P/hA5khqs/+gyCTrk95sNEmca3fIEv7ijSZh5hE8nXFtabnNSHcr0NFMZEbCLXKNYwQiwZzj5
 PVrpr/bzz7LmvBTLl8QzkcV37XpGRBi93ulsP1qpq2PBJDfexrXVYYN4+yJrusZliNYgTnK4BT7
 8SeQlFINsD/smzPEvi97HskAnAi9mFArPlOPgpHL7fDzIIsq4kOeyOL9P7k7P3h7/i8lv1aqX/K
 CszKR+sMT+KfMZfzgA/h5BkL1VykhCkSVB1yffRj2FBbZH44w1879xV8yOgZcyJO/5+EsEdb2co
 mDem3/i4mgxUupolj/CNMASuv+bkK/jnYn6cpx16kWZaB8yM8JNf6mhcLHOgA0lTcsfPac+GmNc
 x3Aor9Tf5eoq9ROX3aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030198

Add a resource managed inline wrapper for
of_reserved_mem_device_init_by_name() to complement the existing
devm_of_reserved_mem_device_init_by_idx() and
devm_of_reserved_mem_device_init() helpers.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 include/linux/of_reserved_mem.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index b9fd78123d77..52aacdbf432c 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -133,4 +133,25 @@ static inline int devm_of_reserved_mem_device_init(struct device *dev)
 	return devm_of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
 }
 
+/**
+ * devm_of_reserved_mem_device_init_by_name() - Resource managed of_reserved_mem_device_init_by_name
+ * @dev:	Pointer to the device to configure
+ * @np:		Pointer to the device node with 'memory-region' property
+ * @name:	Name of the selected memory region
+ *
+ * This is a resource managed version of of_reserved_mem_device_init_by_name().
+ * The reserved memory region will be released automatically when the device
+ * is unbound.
+ *
+ * Returns error code or zero on success.
+ */
+static inline int devm_of_reserved_mem_device_init_by_name(struct device *dev,
+							   struct device_node *np,
+							   const char *name)
+{
+	int idx = of_property_match_string(np, "memory-region-names", name);
+
+	return devm_of_reserved_mem_device_init_by_idx(dev, np, idx);
+}
+
 #endif /* __OF_RESERVED_MEM_H */
-- 
2.53.0

