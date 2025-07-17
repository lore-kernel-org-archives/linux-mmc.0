Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1F267B19
	for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745580; cv=none; b=noOIQ1EQKLFZmzG/PNsGKSqDm20wYm/2NFLZ+2lxEgapOpJJ2LhBKnVkcrP9FjGXzurCMO2cPkKnwuUA5X1WePww7UtbLZ+X2Im7R5T8m+oRVXVFe3PsGBoIsVMZv/Mpo4xJh6djpUJkJV6XjtN6iDkHA/n3P0aWGNcVSDplBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745580; c=relaxed/simple;
	bh=SNKCNuS07yOhNClyun4AtdBr5+gzFNw6Inn1wst24b0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jyxJD58qyJuRw+BL+UaOAhBnWksH91xCRTapcCwBHjU9o1wuduyBAGOwYqMgWF96uTv/spEyRsID85SlTKROzaaaXEfw5ZGey8k5kBHvvD8IgEV+brePtXrtkGZtnAEmdN8zDXMI4ANXSadiErj1O+ALuX1wNu4iigWcGolf2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lpcGqe8b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lpcGqe8b"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0c4945c76so103527366b.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2025 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752745576; x=1753350376; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ru/mu5vOTULTD4H+wkh3KmAvhPvotp/lHqkpBJrbBE=;
        b=lpcGqe8bgzQXCJRH9llp8Wup0wahZZ63GZPfBMKuG5xnp5YCX9DgnGmM99AkY0Xiau
         EelPRHsz9UXd4sdm+3caaj8q5YSYNJbEHVXpAoEhMSXhHeCOatKCgK+1P7VNccezQNOR
         idb0Y6pN6yRPvprw/fyvhIivt7bRpNQKXLj85ncRd59+JvsVv/sI7jbcQpXlrNnwnKsx
         /vv61S6PR2F/l/gNOEUXp6lerExDqD/v1LtJzhLIPmUhyE3oKwn5RzWxppp7vNsk2q0n
         ImL/G8IFhPWV0SOX5e5t9Q5MP81EamOv8NuaL21bDHyArTjzwwPj5OvTME0Z2tv2gMlQ
         WN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745576; x=1753350376;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Ru/mu5vOTULTD4H+wkh3KmAvhPvotp/lHqkpBJrbBE=;
        b=pqiEVXM2NslfLA25X6mT+rpMi+rXF8nGf7H9ZW9bl9uRzQ+NaMFzIJ9MpLtdllfvkR
         zZ7e9zQWD9OgqjQybpgxd2V+eLBB6Y1BWk3DNXzgoPuGMjQ29TgTpj7dZgZrIM8Ni1YU
         euNNvTNUh2YBAp8F21HolhL5dEKTVCcKmXdL+fUHn+Q7ke5JbIKLDvnvlVAP617Uf8B4
         6mu0mLS8TlfFC5PbKuY1iAxOr7N2Cfy+chNZfdhkGFgZasLX/s/J+v8297M1JV2boJI/
         cfedy6fYyhswhDD4Trdio5UBV/ewYTGYJuM81hZyMzyHLq8f31oks0En+u3bqTJJIoBR
         tLzg==
X-Forwarded-Encrypted: i=1; AJvYcCUgXYiGemF8F8nrFT3NZkO8rCtp45qVZ2FyVA8rQ3n5dHopudjIWVYLy1qZvzAbP8vtqLeQMLo10F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2vjyIqtcK7kPy31dPkpG1c+CNH48ue+AjsbT9KbRlvOLuaYl
	LWl3EDoMOjoXQLNqG5BUTYnFiLvuZebzLdkj6G5gCTeTLrNY0STAzSFVyCfSEmEdNeY=
X-Gm-Gg: ASbGnctVdPHxTYasxJ4yDvOS75sYMo5S0579vwzsvoHBQZAJ6B5YYT9/KnRc2Qo8cgM
	gQoQAjkj+nJ4jYKWOIds4k3sDw+XOH/7coHmRDmqu8fyN8BucKZAS/FexhP1hku1mC7mRKUVTvN
	Z+GWnt6n879Ix6Tf0vok9x7X9+JTfE9/qWq1un0J6NphqMRJrOA5E4v7k0MDWRfZ5lKM2pqLMo5
	ImhW4rPG2RXUeM3u4clGC6CQCXhre7MzhCvdVQ55Ryk6GRXxmZEh92Y8UmcPRsa41q5UEL3OsFB
	9O9gTuXqSN5kaL4QMmG/mBEpOFl3QOCobzBWvL+P2Xq1Hem7NuMaASS2W45rPjSr6whpVKFzAeW
	2EjkpgyGk3qYbP76wIpklDNE4210pEXRmlC3fonoYUZDktCZIeZjkIvkV
X-Google-Smtp-Source: AGHT+IFFJ+Gwq77Z/PIy0XMlE+NNaiR8R9S0OSFVxrU0iuecWvqgNe/XZ2Nw4b7IKr3qQanK/C4caw==
X-Received: by 2002:a17:906:af16:b0:ad8:87ae:3f66 with SMTP id a640c23a62f3a-ae9ce1d8ba4mr400610566b.60.1752745576031;
        Thu, 17 Jul 2025 02:46:16 -0700 (PDT)
Received: from localhost (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bb2sm1333325866b.114.2025.07.17.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 11:46:12 +0200
Message-Id: <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Will Deacon" <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Vinod Koul" <vkoul@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Robert Marko" <robimarko@gmail.com>, "Das
 Srinagesh" <quic_gurus@quicinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>, "Amit
 Kucheria" <amitk@kernel.org>, "Thara Gopinath" <thara.gopinath@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui"
 <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
In-Reply-To: <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>

Hi Konrad,

On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>> Add a devicetree description for the Milos SoC, which is for example
>>> Snapdragon 7s Gen 3 (SM7635).
>>>=20
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> [...]
>>> +
>>> +		spmi_bus: spmi@c400000 {
>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>
>> There's two bus instances on this platform, check out the x1e binding
>
> Will do

One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can't
reuse the existing PMIC dtsi files since they all reference &spmi_bus.

On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
connected to anything so just adding the label spmi_bus on spmi_bus0
would be fine.

Can I add this to the device dts? Not going to be pretty though...

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/=
boot/dts/qcom/milos-fairphone-fp6.dts
index d12eaa585b31..69605c9ed344 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -11,6 +11,9 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "milos.dtsi"
+
+spmi_bus: &spmi_bus0 {};
+
 #include "pm7550.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmiv0104.dtsi" /* PMIV0108 */

Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
other designs than SM7635 recommend using spmi_bus1 for some stuff.

But I guess longer term we'd need to figure out a solution to this, how
to place a PMIC on a given SPMI bus, if reference designs start to
recommend putting different PMIC on the separate busses.

Regards
Luca
