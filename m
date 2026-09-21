Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD144FE2F7;
	Mon, 21 Sep 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014754; cv=none; b=NttqMpag2gCg2xVKi7gwtTjzjgcaykL+8q1jSI7yC5AjFTx28lMsioLhkI1XsFPEKE9KZPJNUMrAJENeimtC4JFPwEu1b+XtaWIbuIjPe3KMNtZfxl4maGRK6+5X9b1BWcMZZkelBFYBQhyicXkDYKau3J8wt7mhK3Wpyobx2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014754; c=relaxed/simple;
	bh=lN9T+SnZbhrnmjxbeR5SCQJLtUqETglj+iS5dEIdadI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKiF6/i/cM9I82bFrBGX9AJWWh6GVm7vBuyjUJP/m6H5RwpN/XkBQcrniZIJTYfIj9KP/FbW7o3zPrJkWIrZaEF/CUVGXxD/YVMWMqI8Iuk0K6z35haQUcaaJdLnr4SHmUFkIWcW/PHS06NRpGn+YC3GKqBa+AuTDTIBcGy26wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSGe/ITT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSGe/ITT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DE7EC2BCFF;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790014753;
	bh=lN9T+SnZbhrnmjxbeR5SCQJLtUqETglj+iS5dEIdadI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uSGe/ITTPe3Nljy66DLqhDI9rIMn/EABVSu41FuqVnZOJNn9n6Aw4P+7+Y6U30gaJ
	 dMz+WAZeUmzJxDADYztiMsyoPVAdpVZ/BOPDOYf1h8BsnXx34OHJ1BKl7ggTb5viYc
	 EOja2uO28QZ6GACskkj4PXqBU+dWAgLIWsIxnBNJvc19d4tvi3KMC0VR2ZLxhCOZH5
	 eoXBRAjtjmZgDRBmfLLVOx/pKq4e70IzYT7s6UM2XrusTg4kxCX+XtwFN32HnmK2E3
	 fw4yhCqb+Wp4xRaVk17cyMqmUr7F6vWLwa1gH9/SvZifO1HfpsBf+1f+qJOS4cvWQF
	 nhPGTYfIPOo1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8074DC982FA;
	Mon, 21 Sep 2026 18:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Mon, 21 Sep 2026 21:19:05 +0300
Subject: [PATCH v3 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, 
 linux-input@vger.kernel.org, Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790014748; l=1046;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=wTQZRJDoSbh+aK8zsamDgiJT0DGZohLPPtS+hjHbra4=;
 b=n1lp4+U7Yh5t8+vd3zap8e9dK5jdFN+aOP91W7fWczSgbfTQZcB8SSEsvOooA9L6WjpYpjTrJ
 e1CYQqKxYLbDniOP6fLzy8l3+5cYhz9WFVxZrr4fIlG3XFfXXNdv7XX
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 36c90f72943f..53c1df3ca641 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -130,6 +130,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,msm8937", .data = &ubwc_1_0_hbb14 },
 	{ .compatible = "qcom,msm8929", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
+	{ .compatible = "qcom,msm8952", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8953", .data = &ubwc_1_0_hbb14 },
 	{ .compatible = "qcom,msm8956", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8974", .data = &no_ubwc_data },

-- 
2.55.0


