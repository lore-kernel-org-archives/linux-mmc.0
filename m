From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: eMMC 4.51
Date: Wed, 9 Oct 2013 11:00:56 -0700
Message-ID: <CACUGKYPn-qL2_z83wK0EYtDexmyYQX6YVPwHTp5C4_d2M9BH4w@mail.gmail.com>
References: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
	<CA+6rjLzLhA-zzTqWuzFCMXa1v9CgS-O+Rrnqsfpw9=UY_1vuMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40034 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3JISA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 14:00:58 -0400
Received: by mail-ie0-f170.google.com with SMTP id x13so2788483ief.29
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2013 11:00:57 -0700 (PDT)
In-Reply-To: <CA+6rjLzLhA-zzTqWuzFCMXa1v9CgS-O+Rrnqsfpw9=UY_1vuMA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jackey Shen <jackey.shen.bo@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b29396@freescale.com

Hi Jackey,

The Marvel SD8797 work fine but there are some cases that the firmware
failed to load during the system boot up. Although, we managed it by
power cycling the power source of the Marvel chip so that the kernel
will able to detect and reinitialize again.

The module was running in high speed, 4bit bus width.

Here are some info:

# iperf -c 192.168.x.x -t 60 -i 10
------------------------------------------------------------
Client connecting to 192.168.x.x, TCP port 5001
TCP window size: 20.7 KByte (default)
------------------------------------------------------------
[  3] local 192.168.x.x port 52071 connected with 192.168.x.x port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  48.0 MBytes  40.3 Mbits/sec
[  3] 10.0-20.0 sec  53.4 MBytes  44.8 Mbits/sec
[  3] 20.0-30.0 sec  53.8 MBytes  45.1 Mbits/sec
[  3] 30.0-40.0 sec  56.4 MBytes  47.3 Mbits/sec
[  3] 40.0-50.0 sec  54.2 MBytes  45.5 Mbits/sec
[  3] 50.0-60.0 sec  53.5 MBytes  44.9 Mbits/sec
[  3]  0.0-60.0 sec   319 MBytes  44.6 Mbits/sec

# iwconfig mlan0
mlan0     IEEE 802.11abgn  ESSID:"Pxx-xxx"
          Mode:Managed  Frequency:2.437 GHz  Access Point: BC:Dx:xx:xx:xx:xx
          Bit Rate=135 Mb/s
          Retry  long limit:7   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:on
          Link Quality=70/70  Signal level=-28 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

Regards,

john



On Wed, Oct 9, 2013 at 12:23 AM, Jackey Shen <jackey.shen.bo@gmail.com> wrote:
> Hi John,
>
> Does wifi module (Marvel SD8797) work fine on your board? What speed does it
> run at? SDR104?
>
> Thanks,
> Jackey
>
> On Wed, Oct 9, 2013 at 10:00 AM, John Tobias <john.tobias.ph@gmail.com>
> wrote:
>>
>> Hello,
>>
>> I am using git://gitorious.org/thierryreding/linux-next.git to boot my
>> custom board based on iMX6 sololite. My board has SanDisk iNAND 4.51
>> I/F and wifi module (Marvel SD8797). The latest update of
>> sdhci-esdhc-imx.c supports DDR50/SDR50/SDR104 and I would like to use
>> it for my device.
>>
>> In my .dts file, I have the following settings:
>>
>> /* WIFI module */
>> &usdhc2 {
>> pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> pinctrl-0 = <&pinctrl_usdhc2_2_default>;
>> pinctrl-1 = <&pinctrl_usdhc2_3_100mhz>;
>> pinctrl-2 = <&pinctrl_usdhc2_4_200mhz>;
>> bus-width = <4>;
>> status = "okay";
>> };
>>
>> /* eMMC module  */
>> &usdhc4 {
>> pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> pinctrl-0 = <&pinctrl_usdhc4_2_default>;
>> pinctrl-1 = <&pinctrl_usdhc4_3_100mhz>;
>> pinctrl-2 = <&pinctrl_usdhc4_4_200mhz>;
>> bus-width = <8>;
>> status = "okay";
>> compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
>> reg = <0x0219c000 0x4000>;
>> };
>>
>> Then, in my .dtsi file:
>>
>> usdhc2 {
>> /*WIFI pinmux */
>> pinctrl_usdhc2_2_default: default {
>> fsl,pins = <
>> EVT1_PAD_SD2_CMD__SD2_CMD     0x17039
>> EVT1_PAD_SD2_CLK__SD2_CLK     0x17039
>> EVT1_PAD_SD2_DATA0__SD2_DATA0 0x17039
>> EVT1_PAD_SD2_DATA1__SD2_DATA1 0x17039
>> EVT1_PAD_SD2_DATA2__SD2_DATA2 0x17039
>> EVT1_PAD_SD2_DATA3__SD2_DATA3 0x17039
>> >;
>> };
>>
>> pinctrl_usdhc2_3_100mhz: state_100mhz { /* 100Mhz */
>> fsl,pins = <
>> EVT1_PAD_SD2_CMD__SD2_CMD 0x170B9
>> EVT1_PAD_SD2_CLK__SD2_CLK 0x100B9
>> EVT1_PAD_SD2_DATA0__SD2_DATA0 0x170B9
>> EVT1_PAD_SD2_DATA1__SD2_DATA1 0x170B9
>> EVT1_PAD_SD2_DATA2__SD2_DATA2 0x170B9
>> EVT1_PAD_SD2_DATA3__SD2_DATA3 0x170B9
>> >;
>> };
>>
>> pinctrl_usdhc2_4_200mhz: state_200mhz { /* 200Mhz */
>> fsl,pins = <
>> EVT1_PAD_SD2_CMD__SD2_CMD 0x170F9
>> EVT1_PAD_SD2_CLK__SD2_CLK 0x100F9
>> EVT1_PAD_SD2_DATA0__SD2_DATA0 0x170F9
>> EVT1_PAD_SD2_DATA1__SD2_DATA1 0x170F9
>> EVT1_PAD_SD2_DATA2__SD2_DATA2 0x170F9
>> EVT1_PAD_SD2_DATA3__SD2_DATA3 0x170F9
>> >;
>> };
>> };
>>
>> usdhc4 {
>> /* eMMC pinmux */
>> pinctrl_usdhc4_2_default: default {
>> fsl,pins = <
>> EVT1_PAD_EPDC_BDR1__SD4_CMD       0x17039
>> EVT1_PAD_EPDC_BDR0__SD4_CLK       0x10039
>> EVT1_PAD_EPDC_PWR_COM__SD4_DATA0  0x17039
>> EVT1_PAD_EPDC_PWR_IRQ__SD4_DATA1  0x17039
>> EVT1_PAD_EPDC_PWR_STAT__SD4_DATA2 0x17039
>> EVT1_PAD_EPDC_PWR_WAKE__SD4_DATA3 0x17039
>> EVT1_PAD_FEC_MDC__SD4_DATA4 0x17039
>> EVT1_PAD_FEC_RX_DATA0__SD4_DATA5  0x17039
>> EVT1_PAD_FEC_TX_EN__SD4_DATA6     0x17039
>> EVT1_PAD_FEC_TX_DATA1__SD4_DATA7  0x17039
>> >;
>> };
>>
>> pinctrl_usdhc4_3_100mhz: state_100mhz { /* 100Mhz */
>> fsl,pins = <
>> EVT1_PAD_EPDC_BDR1__SD4_CMD 0x170B9
>> EVT1_PAD_EPDC_BDR0__SD4_CLK   0x100B9
>> EVT1_PAD_EPDC_PWR_COM__SD4_DATA0 0x170B9
>> EVT1_PAD_EPDC_PWR_IRQ__SD4_DATA1 0x170B9
>> EVT1_PAD_EPDC_PWR_STAT__SD4_DATA2 0x170B9
>> EVT1_PAD_EPDC_PWR_WAKE__SD4_DATA3 0x170B9
>> EVT1_PAD_FEC_MDC__SD4_DATA4 0x170B9
>> EVT1_PAD_FEC_RX_DATA0__SD4_DATA5  0x170B9
>> EVT1_PAD_FEC_TX_EN__SD4_DATA6     0x170B9
>> EVT1_PAD_FEC_TX_DATA1__SD4_DATA7  0x170B9
>> >;
>> };
>>
>> pinctrl_usdhc4_4_200mhz: state_200mhz { /* 200Mhz */
>> fsl,pins = <
>> EVT1_PAD_EPDC_BDR1__SD4_CMD 0x170F9
>> EVT1_PAD_EPDC_BDR0__SD4_CLK   0x100F9
>> EVT1_PAD_EPDC_PWR_COM__SD4_DATA0 0x170F9
>> EVT1_PAD_EPDC_PWR_IRQ__SD4_DATA1 0x170F9
>> EVT1_PAD_EPDC_PWR_STAT__SD4_DATA2 0x170F9
>> EVT1_PAD_EPDC_PWR_WAKE__SD4_DATA3 0x170F9
>> EVT1_PAD_FEC_MDC__SD4_DATA4 0x170F9
>> EVT1_PAD_FEC_RX_DATA0__SD4_DATA5  0x170F9
>> EVT1_PAD_FEC_TX_EN__SD4_DATA6     0x170F9
>> EVT1_PAD_FEC_TX_DATA1__SD4_DATA7  0x170F9
>> >;
>> };
>> };
>>
>>
>> 1. After using the said pinmux settings, the sdhci-esdh-imx controller
>> wasn't able to configure it correctly due the the group name for the
>> two port were the same (default, state_100mhz, state_200mhz).
>>
>> 2. Then, I temporarily disabled usdhc4 to test if the driver able to
>> enable the SDR50 for my wifi. Then, I was getting the following
>> errors:
>>
>> [    1.655024] mmc0: error -110 whilst initialising SDIO card
>> [    3.746340] mmc0: error -110 whilst initialising SDIO card
>> [    3.818624] mmc0: host doesn't support card's voltages
>> [    3.823783] mmc0: error -22 whilst initialising SDIO card
>> [    3.901670] mmc0: host doesn't support card's voltages
>> [    3.906862] mmc0: error -22 whilst initialising SDIO card
>> [   34.307777] mmc0: host doesn't support card's voltages
>> [   34.312980] mmc0: error -22 whilst initialising SDIO card
>>
>> 3. Then, I tried the eMMC to see if the driver able to enable the
>> DDR50. After booting it, the kernel detect the eMMC only in hight
>> speed mode.
>>
>>
>> I would like to know if anyone here can help me to figure out how to
>> enable the DDR50 for my eMMC and SDR50 for my wifi as well.
>>
>> Regards,
>>
>> john
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
