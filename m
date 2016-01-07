From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 00/12] Add the family patches to support for kylin board
Date: Thu, 07 Jan 2016 11:44:22 +0100
Message-ID: <1759945.VO3mCQb2oc@phil>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-rockchip@lists.infradead.org, leecam@google.com, leozwang@google.com, keescook@google.com, Andreas Fenkart <afenkart@gmail.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, NeilBrown <neil@brown.name>, linux-clk@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

Hi Caesar,

Am Donnerstag, 7. Januar 2016, 16:25:43 schrieb Caesar Wang:
> Hi all,
> 
> Happy new year! :)
> Let's go on working for happy.

please make sure to split your patch-series at appropriate points for future 
versions to only address relevant people. For example I don't think Ulf 
really cares about getting the audio-related or general devicetree patches.


Heiko

> This series patches are based on kernel version 4.4.0-rc8+
> (Linux version 4.4.0-rc8+ (wxt@ubuntu)...#142 SMP Thu Jan 7 12:38:40 CST
> 2016)
> 
> This series pacthes are verified on the following github:
> https://github.com/Caesar-github/rockchip/commits/kylin-develop4.4
> 
> This series has 12 patches: (12--->1)
> bbd1a01 ARM: dts: Add pl330-broken-no-flushp quirk for rk3036 SoCs
> fb8c1fd ARM: dts: rockchip: add the lcdc and hdmi node for rk3036
> 1aeb49d ARM: dts: rockchip: add the sdmmc for kylin board
> 3e19128 ARM: dts: rockchip: enable the uart0 for kylin board
> e7de154 ARM: dts: rockchip: add the wifi/bt regulator for kylin board
> 8699698 ARM: dts: rockchip: enable the high speed on sdio for kylin board
> 21eded4 mmc: pwrseq: add support for power-on sequencing through DT
> cdf3a7e mmc: pwrseq: Document optional exteral vcc for the simple power
> sequence 131c249 clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag
> for sclk_i2s_out b7ff8e1 ARM: dts: rockchip: override the clocks in i2s
> for kylin board 5f56af4 ARM: dts: rockchip: add the sound codec for kylin
> board
> 914d9c0 ARM: dts: rockchip: set the pinctrl default setting for rk3036 i2s
> ..
> 
> This series patches have the following decriptions:
> 
> PATCH[1/12-4/12]:====> Support rt5616 codec for kylin board
> 914d9c0 ARM: dts: rockchip: set the pinctrl default setting for rk3036 i2s
> 5f56af4 ARM: dts: rockchip: add the sound codec for kylin board
> b7ff8e1 ARM: dts: rockchip: override the clocks in i2s for kylin board
> 131c249 clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag for
> sclk_i2s_out
> 
> This patches is working for codec rt5616 on kylin board. (RK3036 SoCs)
> 
> That's needed the following rt5616 driver from Mark Brown Branch.
> (cherry picked from git.kernel.org broonie/sound.git for-next)
> 
> cf94b7a UPSTREAM: ASoC: rt5616: rename some alsa control names
> 86f561d UPSTREAM: ASoC: rt5616: add devicetree document for rt5616
> 0e0f5f8 UPSTREAM: ASoC: rt5616: add an of_match table
> 263a330 UPSTREAM: ASoC: rt5616: Return error if device ID mismatch
> 0094139 UPSTREAM: ASoC: rt5616: add rt5616 codec driver
> 
> Notes:
> I'm run it with the ubuntu 15.04 to set the configure.
> ./amixer "HP Playback Switch" 1
> ./amixer "HP Playback Volume" 20
> ./amixer "HPO MIX DAC1 Switch" 1
> ./amixer "OUT MIXR DAC R1 Switch" 1
> ./amixer "OUT MIXL DAC L1 Switch" 1
> ./amixer "Stereo DAC MIXR DAC R1 Switch" 1
> ./amixer "Stereo DAC MIXL DAC L1 Switch" 1
> 
> root@linaro-alip:/media/aplay# ./aplay pcm.wav
> Playing sample: 2 ch, 48000 hz, 16 bit
> ..
> That can be normal playing the music.
> ----
> 
> PATCH[5/12-9/12]: ====> Support wifi/bt module for kylin board
> cdf3a7e mmc: pwrseq: Document optional exteral vcc for the simple power
> sequence 21eded4 mmc: pwrseq: add support for power-on sequencing through
> DT 8699698 ARM: dts: rockchip: enable the high speed on sdio for kylin
> board e7de154 ARM: dts: rockchip: add the wifi/bt regulator for kylin
> board 3e19128 ARM: dts: rockchip: enable the uart0 for kylin board
> 
> The wifi/bt driver hasn't land in mainline, the driver is in here:
> https://github.com/Caesar-github/rockchip/commit/1912ef4c0e358677904b0a0bb
> b83f9745066f0ec
> 
> wpa_supplicant -Dnl80211 -c /etc/wifi/wpa_supplicant.conf -i wlan0 -B
> wpa_cli add_network
> wpa_cli set_network 1 ssid \"wxt\"
> wpa_cli set_network 1 psk \"123456789\"
> wpa_cli select_network 1
> wpa_cli save_config
> 
> ifconfig wlan0 192.168.1.105
> route add default gw 192.168.1.1
> 
> root@linaro-alip:/# ping 192.168.1.1
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
> 64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=6.83 ms
> 64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=184 ms
> 64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=9.21 ms
> 64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=6.84 ms
> 64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=11.2 ms
> 64 bytes from 192.168.1.1: icmp_seq=6 ttl=64 time=9.24 ms
> 64 bytes from 192.168.1.1: icmp_seq=7 ttl=64 time=12.9 ms
> 64 bytes from 192.168.1.1: icmp_seq=8 ttl=64 time=7.02 ms
> 64 bytes from 192.168.1.1: icmp_seq=9 ttl=64 time=24.3 ms
> 64 bytes from 192.168.1.1: icmp_seq=10 ttl=64 time=13.6 ms
> 64 bytes from 192.168.1.1: icmp_seq=11 ttl=64 time=3.87 m
> ...
> 
> The wifi throughput:
> 
> iperf -s -i 1
> ...
> [  4] 116.0-117.0 sec  2.88 MBytes  24.1 Mbits/sec
> [  4] 117.0-118.0 sec  2.99 MBytes  25.0 Mbits/sec
> [  4] 118.0-119.0 sec  3.01 MBytes  25.2 Mbits/sec
> [  4] 119.0-120.0 sec  2.89 MBytes  24.2 Mbits/sec
> [  4]  0.0-120.4 sec   332 MBytes  23.1 Mbits/sec
> ----
> 
> PATCH[10/12]: ====> sdmmc patch for kylin board
> ARM: dts: rockchip: add the sdmmc for kylin board
> 
> You should mark it "oaky" if you want to use the sdmmc.
> This patch default is disabing the sdmmc since the sdmmc and
> uart2(debug port) is reusing pin.
> ----
> 
> PATCH[11/12]: ====> hdmi/lcdc diaply patch for rk3036 dts
> ARM: dts: rockchip: add the lcdc and hdmi node for rk3036
> 
> We can add this patch to support it since the Mark Yao has land
> your vop support.
> https://github.com/markyzq/kernel-drm-rockchip/commits/drm-rockchip-next-2
> 015-12-28 ----
> 
> PATCH[12/12]:====> DMA Patchs
> ARM: dts: Add pl330-broken-no-flushp quirk for rk3036 SoCs
> 
> In order to be better read/write for emmc.
> This patch is based on the following:(Fix broken DMAFLUSHP on Rockchips
> platform)
> 
> 3055695 FROMLIST: DMA: dmaengine: expose max burst capability to clientmZ
> (am from https://patchwork.kernel.org/patch/7399361/)
> ed56bee FROMLIST: DMA: pl330: add quirk for broken no flushp
> (am from https://patchwork.kernel.org/patch/7399371/)
> 0c43bc3 FROMLIST: Documentation: arm-pl330: add description of arm,
> pl330-broken-no-flushp (am from
> https://patchwork.kernel.org/patch/7399371/)
> 623a699 FROMLIST: DMA: pl330: support burst mode for dev-to-mem and
> mem-to-dev transmit (am from https://patchwork.kernel.org/patch/7399381/)
> ----
> 
> 
> Changes in v2:
> - modify the commit.
> - fix the mclk-fs as the 256.
> - This fix inmmc-power-sequences, as Heiko comment on
>   https://patchwork.kernel.org/patch/7903161/
> - As Heiko comment, modify it to fit the simple-mmc-sequence.
> - Add the uart0 commit content.
> 
> Caesar Wang (12):
>   ARM: dts: rockchip: set the pinctrl default setting for rk3036 i2s
>   ARM: dts: rockchip: add the sound codec for kylin board
>   ARM: dts: rockchip: override the clocks in i2s for kylin board
>   clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag for
>     sclk_i2s_out
>   mmc: pwrseq: Document optional exteral vcc for the simple power
>     sequence
>   mmc: pwrseq: add support for power-on sequencing through DT
>   ARM: dts: rockchip: enable the high speed on sdio for kylin board
>   ARM: dts: rockchip: add the wifi/bt regulator for kylin board
>   ARM: dts: rockchip: enable the uart0 for kylin board
>   ARM: dts: rockchip: add the sdmmc for kylin board
>   ARM: dts: rockchip: add the lcdc and hdmi node for rk3036
>   ARM: dts: Add pl330-broken-no-flushp quirk for rk3036 SoCs
> 
>  .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |   9 ++
>  arch/arm/boot/dts/rk3036-kylin.dts                 | 119
> +++++++++++++++++++++ arch/arm/boot/dts/rk3036.dtsi                     
> |  74 +++++++++++-- drivers/clk/rockchip/clk-rk3036.c                  | 
>  2 +-
>  drivers/mmc/core/pwrseq_simple.c                   |  16 +++
>  5 files changed, 213 insertions(+), 7 deletions(-)
