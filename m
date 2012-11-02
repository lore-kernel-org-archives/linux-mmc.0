From: Philip Rakity <prakity@nvidia.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Fri, 2 Nov 2012 18:27:15 +0100
Message-ID: <599D17EC-B3F7-437E-89B7-5A5B986B0CE1@nvidia.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
 <CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:13889 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758141Ab2KBR1Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Nov 2012 13:27:24 -0400
In-Reply-To: <CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 2, 2012, at 2:35 PM, Johan Rudholm <jrudholm@gmail.com> wrote:

> Hi Daniel,
>=20
> 2012/10/30 Daniel Drake <dsd@laptop.org>:
>> Hi,
>>=20
>> Following on from the recent thread
>>  [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail
>> I have tried to get a better grip on the problems being faced.
>>=20
>> Test setup:
>> OLPC XO-1.75 laptop, based on Marvell MMP2 ARM SoC (includes sdhci-p=
xa
>> interface)
>> 32GB Sandisk Ultra SD card being inserted into external SD slot
>>=20
>> The SoC apparently has support for 1.8V, but we physically do not ha=
ve
>> the right power lines wired on the motherboard, so we need to detect
>> the 1.8V failure and go back to 3.3V mode.
>=20
> An initial question, would it be possible to solve this by disabling
> the UHS support in the host cap, or through a quirk? Maybe this kind
> of solution is not applicable in this scenario? I wonder this because
> I guess it will be very hard to know how a card will react if we firs=
t
> tell it that we're going to switch voltages and then don't, since thi=
s
> is out of spec.
>=20

I submitted a patch a while ago that allows the board specific code to =
change host->caps2
The controller may indicate support for UHS but the board design can pr=
ohibit this.

>> I tracked down what causes this regression. In order to get the
>> failure detection working again, I have to make the following change
>> in mmc_set_signal_voltage():
>>                if (cmd11) {
>>                        host->ios.clock =3D 0;
>> -                       mmc_set_ios(host);
>> +                       //mmc_set_ios(host);
>>                }
>> (i.e. don't mess with ios before asking sdhci to do the voltage swit=
ch)
>>=20
>> and at the top of sdhci_do_1_8v_signal_voltage_switch:
>> +       /* Stop SDCLK */
>> +       clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +       clk &=3D ~SDHCI_CLOCK_CARD_EN;
>> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> (i.e. add the equivalent clock disabling code here)
>=20
> Ok, so this suggests that the SDHCI driver does not stop the clock
> when we set ios.clock =3D 0 and call mmc_set_ios?
>=20
>> With that change, I now get:
>>  mmc2: Signal voltage switch failed, power cycling card (retries =3D=
 10)
>>  mmc2: error -110 whilst initialising SD card
>>=20
>> The -110 error comes from mmc_send_app_op_cond(), but its worth noti=
ng
>> that mmc_send_if_cond() (called immediately above) silently failed
>> with -110 too. Neither of these failed the first time around before
>> 1.8V was tried.
>>=20
>> Full patch that I'm testing with: http://dev.laptop.org/~dsd/2012103=
0/mmc.patch
>>=20
>> So, now the question is: why is the card not responding to
>> if_cond/app_op_cond after being powered down and up again? Is the
>> power down/up sequence OK?
>=20
> Good question. I=92d guess that mmc_power_off/up does not work as
> expected here, that the card is not at all power cycled. But it seems
> that the power cycle code in sdhci_do_start_signal_voltage_switch
> works? What if we export a couple of debug functions from sdhci.c
> which allow us to power cycle and control the clock just like sdhci
> does, and call these functions from core.c and sd.c? If this works
> (and the failure is detected properly by the core layer, and 10
> retries are made etc), then we know that the problems most likely
> depend on how mmc_set_ios and mmc_power_off/up work with sdhci. I've
> attached a patch suggesting this, if you'd like to give it a try
> (warning: the patch has not been tested). The patch does not do
> anything about pm_runtime, but perhaps we don't need to worry about
> this here.
>=20
>> I tried inserting the mmc_power_off, mmc_power_up, mmc_send_if_cond
>> sequence into various points in the codepaths being discussed.
>> Measuring success as the card responding to mmc_send_if_cond(0x30080=
)
>> without error (0x30080 is a known good value from when before 1.8V i=
s
>> tried), I find that this "reset sequence" works just fine up until t=
he
>> point when CMD11 is run.
>> CMD11 is sent and returns successfully without error, but from this
>> point, running the reset sequence will fail (send_if_cond will fail
>> with -110).
>>=20
>> Is this kind of test valid? Does this suggest that something is wron=
g
>> with the host controller hardware? My assumption is that whatever
>> state is modified by CMD11 should be erased here, and of course the
>> hope is that mmc_power_off and mmc_power_up will do a full power cyc=
le
>> anyway. But whatever is happening, it looks like the effects of CMD1=
1
>> are persisting past the reset sequence and are breaking later
>> communication.
>=20
> I think that the power cycle has simply failed here, I find it hard t=
o
> believe that CMD11 has persistent effects :) If mmc_power_off/up
> actually works, then perhaps the 1ms udelay is too small for this
> case?
>=20
> Kind regards, Johan
> <0001-Clock-and-power-control.patch>

-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
