Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4B4D37DB;
	Thu, 17 Sep 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647957; cv=none; b=JUqQAH0zbHIAUxdC8Is1junGFgtzvRwoMc7MedbgaZzIWUbPNvpK8h0QsAdPAOH78xCdY0FSzIoxwQ5r8fRa/FGPtmwG83IfYaee7oo4wh/zy24xPIa7O3B6wAJ7Kan5CHCxgJYbNbskUWfFHpJNv+KeelPD0Tf6g648a0jfQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647957; c=relaxed/simple;
	bh=MO544Wsk/Oafa0bUboIOlCkH6j/N7fUKxAhwOhrTIWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/8eVkICDMcul1s65I7SkNsGDjatglrrDv/Ke6I6xnGTg0Psp+hs/016KLo8eps0fS+K7ItrKLnXz0kv6Hv176M7ggzTy/6MMqswd5aF7pkClQuSu71Ip/iBlBKNlgKh/TKDkiB2KVIlrComTOLOo5DwboWD9ZQZ4CtpojXEHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Message-ID: <a47a1a0e-559b-410c-aa99-9230908c2fe6@mainlining.org>
Date: Thu, 17 Sep 2026 15:25:32 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
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
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 iommu@lists.linux.dev, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
 <af3f7261-e4b0-42fc-818d-80e760cddc2c@oss.qualcomm.com>
From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Content-Language: en-US
In-Reply-To: <af3f7261-e4b0-42fc-818d-80e760cddc2c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Taniya,

On Thu, 17 Sep 2026 09:49:07 +0530, Taniya Das wrote:
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index a6c676f68b79..3c3f27dcc68d 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -89,6 +89,7 @@ obj-$(CONFIG_MSM_GCC_8909) += gcc-msm8909.o
>>  obj-$(CONFIG_MSM_GCC_8916) += gcc-msm8916.o
>>  obj-$(CONFIG_MSM_GCC_8917) += gcc-msm8917.o
>>  obj-$(CONFIG_MSM_GCC_8939) += gcc-msm8939.o
>> +obj-$(CONFIG_MSM_GCC_8952) += gcc-msm8952.o
>>  obj-$(CONFIG_MSM_GCC_8953) += gcc-msm8953.o
>>  obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
>>  obj-$(CONFIG_MSM_GCC_8974) += gcc-msm8974.o
>> diff --git a/drivers/clk/qcom/gcc-msm8952.c b/drivers/clk/qcom/gcc-msm8952.c
>> new file mode 100644
>> index 000000000000..6b82606dfadb
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-msm8952.c
>> @@ -0,0 +1,3550 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2020 Linaro Limited
> 
> https://android.googlesource.com/kernel/msm/+/android-msm-shamrock-3.10-nougat-release/drivers/clk/qcom/clock-gcc-8952.c
> 
> This is our original copyright.
> 
>> + * Copyright 2026 Muzaffer Kadir <muzafferkadir@mainlining.org>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/bitops.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include <dt-bindings/clock/qcom,gcc-msm8952.h>
>> +
>> +#include "common.h"
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "clk-alpha-pll.h"
>> +#include "clk-rcg.h"
>> +#include "clk-branch.h"
>> +#include "reset.h"
>> +#include "gdsc.h"
>> +
> 
> Add DT_BI_TCXO enum.

Should I rename the clock name to bi_tcxo?
Or should I use DT_XO for enum?

Best regards,
Muzaffer Kadir
