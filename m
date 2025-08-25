Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9D2FF643
	for <linux-mmc@vger.kernel.org>; Mon, 25 Aug 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137239; cv=none; b=paOYurb/jKOiFIws8R7hrvtvHJWiIs9I0WE4Shlw+d0GTOvUf5dVcIIEwUJbTgxFAWkX71KDCY35PHxtpNRFSdBlaKQUiylCYY9mOeMTJWxqfWaUfmECnQ1Uez/8uLUegQkD9VnjNTDdNT8J+8wvHol3991pLB7htQsXTESzXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137239; c=relaxed/simple;
	bh=iDIMFaPmP6Ptap4BSySC5MxVV+P3d+K2pyIekorzzbo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UUXC3HH67Ij8ZC4bGe62fakaK44W1/Fdw56e8UhFdCiqBY3bOfuKO1fhlNYq4ypVN/YU46keFOdeVLWqBRTIpJnii6hKgWWt3C0TkJTpS3YanNZZhNRn+bN2ZOPs67CCKUfCr0ymylSm07jxD+y4efEcdqmE/vUxfsJsVYhl72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=YZfbOjbX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="YZfbOjbX"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae31caso834960766b.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Aug 2025 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1756137236; x=1756742036; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HqowhwKhilGiIPsPTFLVOfvfqilXqLVrLNuX0vYRl8=;
        b=YZfbOjbXU2D82c/umEUCVeB4ooJ8i7avhElo6eraE2CwrNaXc77fS4esMaXzTStVxM
         q02PL1NdPxcm1E9yi461tEeuheRgOUwtEDgxpXrl/H5+owKSqvhm/8GigDE6PxMwoHyO
         X1RC5FyvReP/rn+yVTk+NiPujGHjGe6fAP8RufVWs0698xhdz3LtTGHnaqo1411Zr/Zt
         NM8cGaSTj33FANy2kLyzsRGw3Oh7zWw/urkWm3R4SxMaDIb9YxWPm4ms7EC4PZe3L5YD
         rMYOOhmiudp7XvJv037qHYhPyFkkx/7ma6KcXjpvgmkFYXwJI75mQmX77OrI+yzgfLdu
         qM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137236; x=1756742036;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3HqowhwKhilGiIPsPTFLVOfvfqilXqLVrLNuX0vYRl8=;
        b=gF0Jvl+ays9/3sscaEh0hcv58Abog+SjzA7b6OFA2Z6wAjr3bbvBtMJPGot6mMQjE/
         8iiJuchuJZVlQXWTAGBPuJE67b/ubA/ISJdWzbBmOGnmk++BL3AiM6tiEgIxnD+LEJ+R
         Qpmot9bqib4gHxvtB8gkaCXoZ/+28+BA+n5/Pu3z7ktIbn7J4F549DQ/SiB3GFtFdk3Y
         M0zzADJhV7a0MJQiyQWDUHTybyiweXYIMKN6WRcHGljf8lJCrWXVByIyYi+NUsW1mjAS
         4qWmjPvK+TVZvplfdvZh8L8SEK3qu5nPek+yKebVGbssiEPa47MBJq0mN0AjHlmif2TK
         dI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl1zlHRpk9RfENBGdmlBK7h8LmOga9+T6SWyxY4ocL4slqMRs5LXXzDiaf+kEpUDoNJb7QrMcmhZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtj993ZIePsaIb+pg1aeXG/89I+ElBj9PQAEGx3L1MZ29K5UdJ
	V9cYIxi26broHaMBBwa371e3xufvLzWgItqgk6lYsWnLuTQ8iKILgRLcqcrEw7ZpfpE=
X-Gm-Gg: ASbGncsAr/xkjshW/Ob/xbD7FofXTU5Q74z5qqougTPAoc7qftu46vqaAJaSsawebE6
	9C46oxBGVlmniBrVNdS/l0rxfoqXpogR868MQHq2901ilM1azY5m5nfdTT+1MOI04Fqtlvd1/CD
	MYGk115M4Dgdq10Y9pXQE+XZ0wmxW5fybVNdvSHkhe/epI4XNVWBGRRMV1gGm3ixE/nd3/gdj+K
	ztxdQAYNuiAsHwRYoNrKMd/u+ozhDF56QAyhQwAbo5jLKSM1/p9Hf3YbPjHFuEC1y+jEz41arN4
	gTjadz/AvkA2hgSSgDEPNf2WxjY3LGwav/v47uzfhV149iONPU0U/aKmhiu6KmHSL4uhWyIXkY5
	TxnELcdz4HMtx73fSgHamwKgd/Cn1bwOWlX+wRZv8BVgNNhQmxl7cpisIpNiL6mgCMMW5S5v3vg
	7z2b0=
X-Google-Smtp-Source: AGHT+IEDOv6gprEj6Ksbmo7p57Z4tZTNEHhZ9DTRLeOqT0HCwoH6lmCXLeF8Wklr2ttI5zxfbuX7Eg==
X-Received: by 2002:a17:906:7943:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-afe296e74c2mr1283531066b.40.1756137234813;
        Mon, 25 Aug 2025 08:53:54 -0700 (PDT)
Received: from localhost (83-97-14-181.biz.kpn.net. [83.97.14.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8b5fbc8dsm139360466b.1.2025.08.25.08.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 17:53:53 +0200
Message-Id: <DCBMOZQ7BFI9.2B3A3PEZ0DTYD@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
 <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
 <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>
 <DC74DPI8WS81.17VCYVY34C2F9@fairphone.com>
 <2hv4yuc7rgtglihc2um2lr5ix4dfqxd4abb2bqb445zkhpjpsi@rozikfwrdtlk>
In-Reply-To: <2hv4yuc7rgtglihc2um2lr5ix4dfqxd4abb2bqb445zkhpjpsi@rozikfwrdtlk>

Hi Dmitry,

On Wed Aug 20, 2025 at 1:52 PM CEST, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 10:42:09AM +0200, Luca Weiss wrote:
>> Hi Konrad,
>>=20
>> On Sat Aug 2, 2025 at 2:04 PM CEST, Konrad Dybcio wrote:
>> > On 7/29/25 8:49 AM, Luca Weiss wrote:
>> >> Hi Konrad,
>> >>=20
>> >> On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
>> >>> Hi Konrad,
>> >>>
>> >>> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>> >>>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> >>>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>> >>>>>> Add a devicetree description for the Milos SoC, which is for exam=
ple
>> >>>>>> Snapdragon 7s Gen 3 (SM7635).
>> >>>>>>
>> >>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >>>>>> ---
>> >>>>>
>> >>>>> [...]
>> >>>>>> +
>> >>>>>> +		spmi_bus: spmi@c400000 {
>> >>>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>> >>>>>
>> >>>>> There's two bus instances on this platform, check out the x1e bind=
ing
>> >>>>
>> >>>> Will do
>> >>>
>> >>> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we c=
an't
>> >>> reuse the existing PMIC dtsi files since they all reference &spmi_bu=
s.
>> >>>
>> >>> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is n=
ot
>> >>> connected to anything so just adding the label spmi_bus on spmi_bus0
>> >>> would be fine.
>> >>>
>> >>> Can I add this to the device dts? Not going to be pretty though...
>> >>>
>> >>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch=
/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >>> index d12eaa585b31..69605c9ed344 100644
>> >>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >>> @@ -11,6 +11,9 @@
>> >>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> >>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> >>>  #include "milos.dtsi"
>> >>> +
>> >>> +spmi_bus: &spmi_bus0 {};
>> >>> +
>> >>>  #include "pm7550.dtsi"
>> >>>  #include "pm8550vs.dtsi"
>> >>>  #include "pmiv0104.dtsi" /* PMIV0108 */
>> >>>
>> >>> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sur=
e
>> >>> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>> >>>
>> >>> But I guess longer term we'd need to figure out a solution to this, =
how
>> >>> to place a PMIC on a given SPMI bus, if reference designs start to
>> >>> recommend putting different PMIC on the separate busses.
>> >>=20
>> >> Any feedback on this regarding the spmi_bus label?
>> >
>> > I had an offline chat with Bjorn and we only came up with janky
>> > solutions :)
>> >
>> > What you propose works well if the PMICs are all on bus0, which is
>> > not the case for the newest platforms. If some instances are on bus0
>> > and others are on bus1, things get ugly really quick and we're going
>> > to drown in #ifdefs.
>> >
>> >
>> > An alternative that I've seen downstream is to define PMIC nodes in
>> > the root of a dtsi file (not in the root of DT, i.e. NOT under / { })
>> > and do the following:
>> >
>> > &spmi_busN {
>> > 	#include "pmABCDX.dtsi"
>> > };
>> >
>> > Which is "okay", but has the visible downside of having to define the
>> > temp alarm thermal zone in each board's DT separately (and doing
>> > mid-file includes which is.. fine I guess, but also something we avoid=
ed
>> > upstream for the longest time)
>> >
>> >
>> > Both are less than ideal when it comes to altering the SID under
>> > "interrupts", fixing that would help immensely. We were hoping to
>> > leverage something like Johan's work on drivers/mfd/qcom-pm8008.c,
>> > but that seems like a longer term project.
>> >
>> > Please voice your opinions
>>=20
>> Since nobody else jumped in, how can we continue?
>>=20
>> One janky solution in my mind is somewhat similar to the PMxxxx_SID
>> defines, doing something like "#define PM7550_SPMI spmi_bus0" and then
>> using "&PM7550_SPMI {}" in the dtsi. I didn't try it so not sure that
>> actually works but something like this should I imagine.
>>=20
>> But fortunately my Milos device doesn't have the problem that it
>> actually uses both SPMI busses for different PMICs, so similar to other
>> SoCs that already have two SPMI busses, I could somewhat ignore the
>> problem and let someone else figure out how to actually place PMICs on
>> spmi_bus0 and spmi_bus1 if they have such a hardware.
>
> I'd say, ignore it for now.

You mean ignoring that there's a second SPMI bus on this SoC, and just
modelling one with the label "spmi_bus"? Or something else?


I have also actually tried out the C define solution that I was writing
about in my previous email and this is actually working, see diff below.
In my opinion it just expands on what we have with the SID defines, so
shouldn't be tooo unacceptable :)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/=
boot/dts/qcom/milos-fairphone-fp6.dts
index 9fb174592e2d..96e1b5df4f65 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -7,6 +7,12 @@
=20
 #define PMIV0104_SID 7
=20
+#define PM7550_SPMI spmi_bus0
+#define PM8550VS_SPMI spmi_bus0
+#define PMIV0104_SPMI spmi_bus0
+#define PMK8550_SPMI spmi_bus0
+#define PMR735B_SPMI spmi_bus0
+
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/pm7550.dtsi b/arch/arm64/boot/dts/qco=
m/pm7550.dtsi
index b886c2397fe7..08d7969128c2 100644
--- a/arch/arm64/boot/dts/qcom/pm7550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7550.dtsi
@@ -34,7 +34,7 @@ trip1 {
 	};
 };
=20
-&spmi_bus {
+&PM7550_SPMI {
 	pm7550: pmic@1 {
 		compatible =3D "qcom,pm7550", "qcom,spmi-pmic";
 		reg =3D <0x1 SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi b/arch/arm64/boot/dts/q=
com/pm8550vs.dtsi
index 7b5898c263ad..3c8c5f3724a2 100644
--- a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
@@ -91,7 +91,7 @@ trip1 {
 };
=20
=20
-&spmi_bus {
+&PM8550VS_SPMI {
 	pm8550vs_c: pmic@2 {
 		compatible =3D "qcom,pm8550", "qcom,spmi-pmic";
 		reg =3D <0x2 SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pmiv0104.dtsi b/arch/arm64/boot/dts/q=
com/pmiv0104.dtsi
index 85ee8911d93e..bf0c02974e74 100644
--- a/arch/arm64/boot/dts/qcom/pmiv0104.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmiv0104.dtsi
@@ -40,7 +40,7 @@ trip2 {
 	};
 };
=20
-&spmi_bus {
+&PMIV0104_SPMI {
 	pmic@PMIV0104_SID {
 		compatible =3D "qcom,pmiv0104", "qcom,spmi-pmic";
 		reg =3D <PMIV0104_SID SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qc=
om/pmk8550.dtsi
index 583f61fc16ad..f1c34f0a2522 100644
--- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -18,7 +18,7 @@ reboot-mode {
 	};
 };
=20
-&spmi_bus {
+&PMK8550_SPMI {
 	pmk8550: pmic@0 {
 		compatible =3D "qcom,pm8550", "qcom,spmi-pmic";
 		reg =3D <0x0 SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pmr735b.dtsi b/arch/arm64/boot/dts/qc=
om/pmr735b.dtsi
index 09affc05b397..91b53348a4ae 100644
--- a/arch/arm64/boot/dts/qcom/pmr735b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
@@ -30,7 +30,7 @@ pmr735b_crit: pmr735a-crit {
 	};
 };
=20
-&spmi_bus {
+&PMR735B_SPMI {
 	pmr735b: pmic@5 {
 		compatible =3D "qcom,pmr735b", "qcom,spmi-pmic";
 		reg =3D <0x5 SPMI_USID>;
