From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 3/5] mmc: core: implement enhanced strobe support
Date: Tue, 24 May 2016 18:25:35 +0800
Message-ID: <53532571-a8c3-8916-4e98-fd497e37a3ae@rock-chips.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160523041529epcas1p3ab7a79120c0ef135fbca109eede66883@epcas1p3.samsung.com>
 <1463976835-29780-1-git-send-email-shawn.lin@rock-chips.com>
 <574425A3.6090303@samsung.com>
 <1f67fa2e-9a14-819d-8d75-3b35be819f0d@rock-chips.com>
 <574429DF.1000501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <574429DF.1000501@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/5/24 18:15, Jaehoon Chung =E5=86=99=E9=81=93:
> On 05/24/2016 07:11 PM, Shawn Lin wrote:
>> =E5=9C=A8 2016/5/24 17:57, Jaehoon Chung =E5=86=99=E9=81=93:
>>> On 05/23/2016 01:13 PM, Shawn Lin wrote:
>>>> Controllers use data strobe line to latch data from devices
>>>> under hs400 mode, but not for cmd line. So since emmc 5.1, JEDEC
>>>> introduces enhanced strobe mode for latching cmd response from
>>>> emmc devices to host controllers. This new feature is optional,
>>>> so it depends both on device's cap and host's cap to decide
>>>> whether to use it or not.
>>>>

[...]

>
> Ok. I have tested with my exynos board. It's working fine.
>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>

Thanks for your test and review, Jaehoon.

> Best Regards,
> Jaehoon Chung
>



--=20
Best Regards
Shawn Lin
