From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: rk3288: mmcblk0: error -110 sending status command, retrying
Date: Thu, 3 Aug 2017 15:05:55 +0530
Message-ID: <CAD6G_RQQJ+i7OPO3M0HvvsjgoP52uHNvtur419eBDtBf9JzKgg@mail.gmail.com>
References: <CAD6G_RRgPB_FVTr0OUdtUXeViben6pSakEcskzwQXkqUeaT2kw@mail.gmail.com>
 <18c3b93d-9db2-eb82-8232-7d141e00324e@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18c3b93d-9db2-eb82-8232-7d141e00324e@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 3, 2017 at 1:48 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2017/8/2 19:09, Jagan Teki wrote:
>>
>> Hi,
>>
>> Did anyone observing error -110 and -84 during boot on rk3288 target?
>> full log here[1] and used dts node is[2].
>
>
> -100 is -ETIMEDOUT and -84 is CRC error. So that seems much likely HW
> relevant. Have you check the SI of SD slot?

Does it means Serial Interface of SD, if yes. I've been added sdio0
for the same.

&sdio0 {
        bus-width = <4>;
        disable-wp;
        non-removable;
        pinctrl-names = "default";
        pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
        vmmc-supply = <&vcc_wl>;
        vqmmc-supply = <&vccio_wl>;
        status = "okay";
};

>
> You don't enable UHS mode so the tuning process won't help.

For UHS switch I've added vqmmc-supply
        vccio_sd: vccio-sd-regulator {
                compatible = "regulator-fixed";
                regulator-name = "vccio_sd";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;
                vin-supply = <&vcc_io>;
        };

And the slot detecting still 50MHz and timeout still effecting.
# fdisk -l
[  120.572927] mmcblk0: error -110 sending status command, retrying
[  120.579880] mmcblk0: error -110 sending status command, retrying
[  120.586707] mmcblk0: error -110 sending status command, aborting
[  120.596373] mmc_host mmc0: Regulator set non-error 0 - 3.3 V
[  120.627875] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req
400000Hz, actual 400000HZ div = 0)
[  120.701757] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot
req 50000000Hz, actual 50000000HZ div = 0)
Disk /dev/mmcblk0: 59 GB, 63483936768 bytes, 123992064 sectors
1937376 cylinders, 4 heads, 16 sectors/track
Units: cylinders of 64 * 512 = 32768 bytes

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
