From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 5/5] mmc: sdhci-of-arasan: implement enhanced strobe
 callback
Date: Tue, 24 May 2016 09:55:05 +0800
Message-ID: <e22866dd-c2d2-e210-e240-9f649cda3e3f@rock-chips.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
 <1463976853-29862-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=X5os7fsCrOh7pDLAt7CSyRw3Q76sFgh-NJhDni02sXdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:53018 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbcEXBzR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2016 21:55:17 -0400
In-Reply-To: <CAD=FV=X5os7fsCrOh7pDLAt7CSyRw3Q76sFgh-NJhDni02sXdA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

=E5=9C=A8 2016/5/24 5:00, Doug Anderson =E5=86=99=E9=81=93:
> Shawn,
>
> On Sun, May 22, 2016 at 9:14 PM, Shawn Lin <shawn.lin@rock-chips.com>=
 wrote:
>> Currently sdhci-arasan 5.1 can support enhanced strobe function,
>> and we now limit it just for "arasan,sdhci-5.1". Add
>> mmc-hs400-enhanced-strobe in DT to enable the function if we're
>> sure our controller can support it.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v5: None
>> Changes in v4: None
>
> Again, minor, but you did have changes...

yes, it did. I moved all the change-log into the
cover-letter but it seems better to keep them seperately
for each patch. I will do it for the next version if
needed. Thanks.

>
>> Changes in v3: None
>> Changes in v2: None
>>
>>  drivers/mmc/host/sdhci-of-arasan.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>
> I've tested this patch and it appears to work (not that I've hooked a
> scope up, but since it's not doing tuning I think it would be pretty
> obvious if it didn't work).
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
>
>


--=20
Best Regards
Shawn Lin

