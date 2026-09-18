Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE324FC343;
	Fri, 18 Sep 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738758; cv=none; b=Zob2kO+sJ24L8jNRdfcU3yRiJ0/aUc3xGVGRKELttzKSDDF24LfOfb6ecEVf43YPVA9+lbuj9eEQ9jyVcoRfa7h+P8e1J8tZoZC7osvCLR1YlEMFXuiyS/7XA3yuzfc/9MBfhPqWE71tJ7d3C77oNxXs0UtyuIUvVJlqdgMF61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738758; c=relaxed/simple;
	bh=2yFgt0ROuksLy413n9Mkj4wxAWjjdsXYuq4ymzuvrHQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t3X5/kUGY7NGKZ5oRGC96oWj3GBHL9rBc2ZlYa8QkTVAYMcGb8CZPSQjePSUDwRjLBfRiTXCYobk1fIdG43wR3LtAIgPRg+NkY8C94UIS4hhsZTwhWRmxb0JXsIliOpPMSfo4Ox5Xo/WybFtBPlMRwIOZheKi8AZIrWJuPqKAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Message-ID: <06462390-f3c2-4018-bd8c-fee513e600ce@mainlining.org>
Date: Fri, 18 Sep 2026 16:38:55 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Subject: Re: [PATCH v2 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
 <20260918-liberal-significant-crow-f1e66f@quoll>
 <29506e08-9337-487f-af2d-b75f5aa8341e@mainlining.org>
 <232b8c59-0357-407b-9e34-78e290f76ba0@kernel.org>
Content-Language: en-US
In-Reply-To: <232b8c59-0357-407b-9e34-78e290f76ba0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Fri, 18 Sep 2026 15:26:34 +0200, Krzysztof Kozlowski wrote:
> On 18/09/2026 15:01, Muzaffer Kadir wrote:
>> Hi Krzysztof,
>>
>> On Fri, 18 Sep 2026 12:02:02 +0200, Krzysztof Kozlowski wrote:
>>> On Wed, Sep 16, 2026 at 05:22:06PM +0300, Muzaffer Kadir wrote:
>>>> Add a device tree binding to describe clocks, resets and power domains
>>>> provided by the global clock controller on MSM8952 SoC.
>>>>
>>>> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>>
>>> Please run scripts/checkpatch.pl on the patches and fix reported
>>> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
>>> patches and (probably) fix more warnings. Some warnings can be ignored,
>>> especially from --strict run, but the code here looks like it needs a
>>> fix. Feel free to get in touch if the warning is not clear.
>>>
>>
>> Then I will ask a few things,
>>
>> WARNING: DT binding headers should be licensed (GPL-2.0-only OR .*)
>> #88: FILE: include/dt-bindings/clock/qcom,gcc-msm8952.h:1:
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>
>> As I said on cover, I originally based on msm8939 gcc,
> 
> I don't get this. There is no file like:
> Documentation/devicetree/bindings/clock/qcom,*msm8939*

this file I was talking about:
include/dt-bindings/clock/qcom,gcc-msm8939.h

> 
> so I have no clue what did you take as a base. If this is derivative of
> some work, it can be mentioned in the commit msg. We usually ignore
> cover letters for anything relevant to actual code.
> 
Understood, I will fix the commit msg on v3.

>> would it cause license problems with file if I fix this
>> warning?
>>
>> Some patches say "has style problems, please review."
>> Is this related to formatting of code inside patch ?
>>
>> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>> #16: 
>> [1] https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> 
> I do not see such line in this patch.

I misunderstood as all patches, Sorry.
This was in 3. patch commit description.

Best Regards,
Muzaffer Kadir
