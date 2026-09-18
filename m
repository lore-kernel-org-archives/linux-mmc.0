Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9948FF67;
	Fri, 18 Sep 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736560; cv=none; b=W0dxzbHNrne/+ijhIq1qUx8xRXwewk2HtKa5k2OcZSiYaNF6yEy4UN0y3Lg4t1sx38U469Li+SW0Us1wJuTdAEs1KfbVtL651UyTWrE4qZFx0RLy26czI69GrC+2oEhqzMTqwL/Wt61EUiNWUUzgegQkRuv0wlD194BkCNIfdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736560; c=relaxed/simple;
	bh=yVcEqSXbP/8mFfz7dHA2v+SFBTVxlkUsy2wH62WCuGg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bkz57M5Dqi0UzjeV364SclpinvmLP7ZYIV/tJe7tI4Y9OdIROTB96cXRNYq2vELWSFD49Bg7SSQIQokl3kErtxoaZKZ9RWK1SmWit8FmJN8x9ktjTs5D4ZFNdWdUtvXKXB6KrBfwnLckskxUP3drwQGRNz4TPYCVCBQGYFhsupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Message-ID: <29506e08-9337-487f-af2d-b75f5aa8341e@mainlining.org>
Date: Fri, 18 Sep 2026 16:01:43 +0300
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
Content-Language: en-US
In-Reply-To: <20260918-liberal-significant-crow-f1e66f@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On Fri, 18 Sep 2026 12:02:02 +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 16, 2026 at 05:22:06PM +0300, Muzaffer Kadir wrote:
>> Add a device tree binding to describe clocks, resets and power domains
>> provided by the global clock controller on MSM8952 SoC.
>>
>> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
> 

Then I will ask a few things,

WARNING: DT binding headers should be licensed (GPL-2.0-only OR .*)
#88: FILE: include/dt-bindings/clock/qcom,gcc-msm8952.h:1:
+/* SPDX-License-Identifier: GPL-2.0-only */

As I said on cover, I originally based on msm8939 gcc,
would it cause license problems with file if I fix this
warning?

Some patches say "has style problems, please review."
Is this related to formatting of code inside patch ?

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#16: 
[1] https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c

Should I move these to "Link:" to fix this type of warnings?
Wouldn't moving them cause a bit understanding loss?

grep: warning: stray \ before -
What does this mean ?

Thanks

>> ---
>>  .../bindings/clock/qcom,gcc-msm8952.yaml           |  56 ++++++
>>  include/dt-bindings/clock/qcom,gcc-msm8952.h       | 217 +++++++++++++++++++++
>>  2 files changed, 273 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml
>> new file mode 100644
>> index 000000000000..274dde633e17
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,gcc-msm8952.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller on MSM8952
>> +
>> +maintainers:
>> +  - Muzaffer Kadir <muzafferkadir@mainlining.org>
>> +
>> +description: |
>> +  Qualcomm global clock control module provides the clocks, resets and power
>> +  domains on MSM8952.
>> +
>> +  See also::
> 
> git grep "also::" -- Documentation/devicetree/bindings/clock/
> 
> I asked you month ago here:
> <e3fb3794-ca7a-4794-8036-b69e563aaa57@kernel.org>
> to not work on old forks.
> 
> Old fork which you should not use is postmarketos, lineageos, whatever
> Android fork kernel, and whatever other tree which is not upstream from
> kernel.org.

I created all of this before sending pinctrl. I tried to clean up by
reading others in upstream before sending but I guess I didn't
noticed that, sorry about that.
I didn't reused fork and mainly used upstream after your reply.

Best regards,
Muzaffer Kadir
