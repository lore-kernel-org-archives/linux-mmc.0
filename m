Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9B3382F4
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107858; cv=none; b=XFsRXtDbVRz4nfHvkXP01aNUdjUVKSfaHg/QVaz87psAiifLczKbXRckzXUCnrvY9+6Uan5rBr6lztTdL5OgKiLF8E2RJmN65LKsqk6EM5QlOWIyPYklUpDgNDl5OSkx0Mb/P2EC0V22TdN6wYK2gXzJTo6Y37Ej/LvfA33Cxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107858; c=relaxed/simple;
	bh=NnhqwgAxxECPDsfxQ59nhG13vP+RTyvfSeIEeTPm5Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBpESzTbenzCcIbHioiNzRTckQGAHruJFlJFy7pxQkp5i0nEX9AluYFvblZNg+Cv7eNPaq9YAcyp7BhwrEZ/gBR/82/NooFSCCqSYXZlcdkPFqmQdAxvOWB3R3Q4sjhXDz2gUC2c+xgBYHdJYW07MIDnjHE1w1ZP0dCJTRYTToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5ePMugh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RfSIPfJ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5ePMugh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RfSIPfJ/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Hj2vg696518
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kb1iTkUxuam
	8tAkzwKjCMRd26ZQOwOz+Yg5JpRpyt18=; b=S5ePMughZWi7SvoZxYwP0onh31h
	eU4cwfBRx3ahw1LCRcXlkaJIXcfIMfCLwR7z/4iUWQKtrflPoO+2yG9bbv2cGOaI
	eUNir+DbQs4W6XkGR/ALtoBJhumLuXvMRvK0mYA6QVyCAnLjKHYfbljJLKY5PKxa
	tajy4e6gizpYUJdNjXNdCBgeIrKnfYLrf4vI3VCgDRtFCFh7PKsQ/HI/9bT++lwS
	r1cCfbVyFKrL3qO0imObXuw8ZZKequ0xSPmvOeGpkhmMbSWbkgyFk8Oy3q7PR/Kz
	4ENgssi0FTweX0znGsCWiiajLsQk1YuBOQeQNyxOeVbk+7xzCdP0FWyGR5A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a84a5h5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 19:44:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-380fe2a3fc7so696066a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107855; x=1783712655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb1iTkUxuam8tAkzwKjCMRd26ZQOwOz+Yg5JpRpyt18=;
        b=RfSIPfJ/BNM5/6MXjrHonz9doWM2jF1TDiYDwN1F1nnQx144bPW3iM9JscsnwiOI/u
         +q9j+7pqmdpJlSgZ54PuP71es66/mgqtmg+Tl37OeGowG0jVKTumtfx8Ic0IuJ1Wh7ag
         BGjFzoDHm8Zbs0Dd68KdRN2WFqSJrBsH8lXunz7Yj7vDBevhlQegitcAhdy/olRI593p
         njSvjaaem3u85IG0mh5Hb1J2TdO9CW+uT2W26P2+Y9W8KMYXnV+npR2/BD8UBohAFhU0
         mR8om8wzvc2vWmxjYA/qmekYF4NMH2m4y/ChtHgyo5VBxXPqMBXzq+wI5BJyi2jany7S
         s3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107855; x=1783712655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kb1iTkUxuam8tAkzwKjCMRd26ZQOwOz+Yg5JpRpyt18=;
        b=p5AjDiLA5O/B3N712MeE5GSY8BOgDdISEJpeCBeGOHCh3LiBiEknWIs8CWqOWiA5W8
         HzF5tCijZ3TnOpZ8nFJ8FqL70vSSsD7JHXonFZJF/b0QNV2Py0ffHqpnC/TF92Tpaied
         kd8GkcRDkpBBfgsw4OfM0qsXx4wf3bz9lQIpawRHJ3HH6xtuTR6lCOiT76vvFapY3cuF
         zg/e19E/JMWK2pUZuuRPVW5mnMozqStYYJdk6POEgzsNoxKH+rc5AfxRkyG0Zq4l+5xr
         m9/XrMYhxYz3Z54zLISsc4dMgzbyzMvn03vfIgM8bvAbZkZ5FfldhYSo92vY/fK4vg1L
         aVBg==
X-Forwarded-Encrypted: i=1; AHgh+RrgkMZJDTkFf6VQZC9kx+xtc7IWiccIW6ikipUuE0ybOtE8u4utl4CyQg2c/t1TSg8nm1cfaWQFdHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxApABf+iZ8sdiObKiOX/U5lGo8d9SkllaUzD3pR9F3Io0HbQPM
	QZ3yCkjutcrEmrZWYRhSDsQ56yzEwsNBgyFg910iOYjkbPDyKvqIHmQjtuRfsxjbJFK7BxUjkUS
	lQnNYX/GM6UpgIbSBCAOIZ/rEN7ulVZkQUQHxYRov8/O3VRZKDxayGL5ecGFWI78=
X-Gm-Gg: AfdE7cnpXGBoKaD8cqSVcarySsD02qxSlQFVDwbkQye4DN/aJcgKdntWxQDb+NrGzTw
	q8xcgX4VyXC37n9vf5+6unfK8WN/n4aqsMYwmGDCE0TG1pWRPnNgYfNBWZAkt8YYP9Opr6liva4
	1AShFKODuxmzRlpaZ911Nq92U+fNc8AYn0+5zynD9iOVvpCAAAizFa/KDJovcfvDNi3PvTg1NCh
	1AHqdQOHPZ0tKe6r6Xaau9S5YbPOqYhLNV9T0WCLS/fd6d5Ro61cho1834DC3ZH41jpLYBswcJH
	FIrz0V6/gAZXEAGnylHYPB8usjl8V/z6tSBTa10KD0fQvyd/UZ9GNafxtqn+uaX1ypMW6TV4fgX
	EAk/r6qmrWrDQtMhiBTjlhNJQ33sGCO9dOI4uiw==
X-Received: by 2002:a17:90b:5550:b0:380:540:d49a with SMTP id 98e67ed59e1d1-382802bcb77mr736184a91.7.1783107854536;
        Fri, 03 Jul 2026 12:44:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5550:b0:380:540:d49a with SMTP id 98e67ed59e1d1-382802bcb77mr736159a91.7.1783107853911;
        Fri, 03 Jul 2026 12:44:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:44:13 -0700 (PDT)
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
Subject: [PATCH 12/42] media: aspeed: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:25 +0530
Message-ID: <20260703193855.110619-13-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: 3kCuI5vgX2HL0KXfM0ias8z2RNW7Ceet
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX9/TTrxUkCXc0
 1EjeUa+7iWrCqIPBYkVE3QgtejMa5MPgHssHFUIS+PiFfzXkPtyv4ewW57Bfb1SczFBm4z5AntI
 XnEx98/25z5k4rFMnFsviABTn3aQ1Vs=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a48110f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=gFEuJ_os7HuwQwkCt6UA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX6GtC/v/VtY+A
 JngXBI/9eCCJ18B+4MCOyttgez6tIWQrIrRgVcZq8avyE7CDB9d7LcxmKpNByuSuW8hmml4T3tO
 ryjthkYW3rSxGKlMBmgyVKqZZWjEECwu8xFqtovaqoBBzVp/vSCkeQjnEIzcvaaDTyvLgw+fguE
 4h/Q1uNdQK7SjNe7CNSgk7aZzBDmw35oFC2SvscptcCbP8aN12N0zNO3CkCVrmOJI+C6PaDhgHx
 4jk09BQI4xPBqZD8Wmnft5/z5xQCD7ecCoAQNQY5cVdQjLru2exiSnwksWSrn4OCePrRVUB5iC9
 Kjh56qL5gDpCOfHJJ422LEEztVKtBpArd4rdIbOE0DXF6G/LUIoWCW3p0bVqh6Tvq9zriWSdoa4
 vAUIJEa58Oui10riharRMQgxRUPGOVS6YcPE4xk5Wi6KXvsQ0nv5LeupsnwFd+DJa+ryI1/jE/8
 l2vbduSy89wss94VEZQ==
X-Proofpoint-ORIG-GUID: 3kCuI5vgX2HL0KXfM0ias8z2RNW7Ceet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the three explicit of_reserved_mem_device_release() calls and
rename the error label from err_release_reserved_mem to
err_unprepare_vclk to reflect that it now only unwinds clock state.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index a292275f6b7b..7ba9314fdbd2 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2267,19 +2267,19 @@ static int aspeed_video_init(struct aspeed_video *video)
 	if (rc)
 		goto err_unprepare_eclk;
 
-	of_reserved_mem_device_init(dev);
+	devm_of_reserved_mem_device_init(dev);
 
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "Failed to set DMA mask\n");
-		goto err_release_reserved_mem;
+		goto err_unprepare_vclk;
 	}
 
 	if (!aspeed_video_alloc_buf(video, &video->jpeg,
 				    VE_JPEG_HEADER_SIZE)) {
 		dev_err(dev, "Failed to allocate DMA for JPEG header\n");
 		rc = -ENOMEM;
-		goto err_release_reserved_mem;
+		goto err_unprepare_vclk;
 	}
 	dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
 		 VE_JPEG_HEADER_SIZE, &video->jpeg.dma);
@@ -2288,8 +2288,7 @@ static int aspeed_video_init(struct aspeed_video *video)
 
 	return 0;
 
-err_release_reserved_mem:
-	of_reserved_mem_device_release(dev);
+err_unprepare_vclk:
 	clk_unprepare(video->vclk);
 err_unprepare_eclk:
 	clk_unprepare(video->eclk);
@@ -2343,7 +2342,6 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
-		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
@@ -2374,8 +2372,6 @@ static void aspeed_video_remove(struct platform_device *pdev)
 	v4l2_device_unregister(v4l2_dev);
 
 	aspeed_video_free_buf(video, &video->jpeg);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static struct platform_driver aspeed_video_driver = {
-- 
2.53.0

