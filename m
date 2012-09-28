From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH Resend 1/2] mmc: sdhci-spear: add device tree bindings
Date: Fri, 28 Sep 2012 06:13:27 -0400
Message-ID: <87626yv4jc.fsf@octavius.laptop.org>
References: <viresh.kumar@linaro.org>
	<a42729885c593f61bb62c45f229174d9f7370c40.1348809217.git.viresh.kumar2@arm.com>
	<87lifuv7rm.fsf@octavius.laptop.org>
	<CAOh2x=mrL6ZT5xR1HMM-r_RQL+J6YE80hq56e9ykndxrEwaHUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59251 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab2I1KNe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Sep 2012 06:13:34 -0400
In-Reply-To: <CAOh2x=mrL6ZT5xR1HMM-r_RQL+J6YE80hq56e9ykndxrEwaHUw@mail.gmail.com>
	(viresh kumar's message of "Fri, 28 Sep 2012 15:19:30 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de

Hi,

On Fri, Sep 28 2012, viresh kumar wrote:
>> You should use a fixed regulator instead of this power-gpio hack.
>> It's easy to hook up a fixed regulator to a gpio:
>>
>>         vmmc1: fixedregulator@0 {
>>                 compatible = "regulator-fixed";
>>                 regulator-name = "fixed-supply";
>>                 regulator-min-microvolt = <1800000>;
>>                 regulator-max-microvolt = <1800000>;
>>                 gpio = <&gpio1 16 0>;
>>                 startup-delay-us = <70000>;
>>                 vin-supply = <&parent_reg>;
>>         };
>>
>> and then you can encode the regulator inside your SD host:
>>
>>         sdhci@fc000000 {
>>                 compatible = "st,spear300-sdhci";
>>                 reg = <0xfc000000 0x1000>;
>>                 cd-gpios = <&gpio0 6 0>;
>>                 vmmc-supply = <&vmmc1>;
>>         };
>>
>> and the MMC core will take care of making sure that it's powered up
>> only when needed.  What do you think?
>
> We haven't used regulator framework till now for SPEAr and i am not much
> knowledgeable in that.
>
> Because i am not adding this power hack now and it had been there
> since ever, i would request you to take this patchset as is..
>
> @Shiraz: Can you please explore this a bit and provide a separate
> patch for it in future?

I think now is a good time to get the DT bindings right instead of
propagating previous hacks into the DT, and this should be a pretty
simple change -- it's not even a code change, since the code for
automatically handling a vmmc-supply exists already.  Once we start
accepting power-gpios properties we can't easily get rid of them later.

If you don't have time to work on this, I guess I could accept the patch
without the power-gpios handling included (since it'll still work with
a DT that provides a vmmc-supply), but I don't want to take the patch
as-is and legitimize the power-gpios binding.  Does that make sense?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
