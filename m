From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device loss]
Date: Tue, 30 Aug 2016 10:14:02 +0200
Message-ID: <CAPDyKFq2SYtwWCNhSzQcxj8XdYmAhTqn6mxRKMJ7eKZAk=itWg@mail.gmail.com>
References: <1472132041.13456.11.camel@researchut.com> <Pine.LNX.4.44L0.1608251254220.1395-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1608251254220.1395-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 25 August 2016 at 19:17, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> Ulf:
>
> Ritesh has collected logs showing that his Realtek RTS5129 USB card
> reader (drivers/mfd/rtsx_usb.c, drivers/mmc/host/rtsx_usb_sdmmc.c) goes
> into runtime autosuspend every 3 seconds and then immediately resumes.
> This sounds like something is failing to call
> pm_runtime_mark_last_busy().  He's using a 4.7 kernel.
>
> In addition, the device gets disconnected from the USB bus from time to
> time.  This appears to be a completely separate issue.
>
> For now, I'd like to fix the runtime PM problem.  But I don't know
> anything about the mmc core, so perhaps you can help.
>

Sorry for the delay! We have had some regressions for 4.8 rc1 in the
mmc block layer. Those problem should be resolved by now.

By reading from the runtime PM issues you have, the problems could
very well be related. Although I don't believe the issues was present
in a 4.7 kernel.

Perhaps you can run a test on a 4.8 rc4 kernel, just to double check.
The 4.8 rc4, contains the following fixes in the mmc block layer.

commit 7afafc8a44bf ("block: Fix secure erase")
commit 869c554808cc ("mmc: fix use-after-free of struct request")

Kind regards
Uffe

>
> On Thu, 25 Aug 2016, Ritesh Raj Sarraf wrote:
>
>> > Do you happen to know which driver is being used: the memstick
>> > (rtsx_usb_ms) or mmc (rtsx_usb_sdmmc) driver?  I suppose this may
>> > depend on what type of card you insert in the reader.
>> >
>>
>>
>> I think it is the rtsx_usb_sdmmc which is in use. I removed the rtsx_usb=
_ms
>> kernel module and still was able to access the sdcard.
>>
>> rrs@learner:~$ lsmod | grep usb_ms
>> 2016-08-25 / 18:45:52 =E2=99=92=E2=99=92=E2=99=92  =E2=98=B9  =3D> 1
>>
>> rrs@learner:~$ lsmod | grep usb_sd
>> rtsx_usb_sdmmc         24576  0
>> rtsx_usb               24576  1 rtsx_usb_sdmmc
>> mmc_core              135168  4 mmc_block,sdhci,sdhci_acpi,rtsx_usb_sdmm=
c
>> 2016-08-25 / 18:45:55 =E2=99=92=E2=99=92=E2=99=92  =E2=98=BA
>>
>>
>> The interesting bit is that when I enter the adapter into the reader, I =
get the
>> following error 5 times, and then it can access the card.
>>
>> [  496.822613] mmc0: tuning execution failed: -22
>> [  496.822629] mmc0: error -22 whilst initialising SD card
>> [  501.980908] mmc0: tuning execution failed: -22
>> [  501.980922] mmc0: error -22 whilst initialising SD card
>> [  507.119953] mmc0: tuning execution failed: -22
>> [  507.119968] mmc0: error -22 whilst initialising SD card
>> [  513.148143] mmc0: tuning execution failed: -22
>> [  513.148157] mmc0: error -22 whilst initialising SD card
>> [  518.702215] mmc0: tuning execution failed: -22
>> [  518.702222] mmc0: error -22 whilst initialising SD card
>> [  524.081122] mmc0: new ultra high speed SDR50 SDHC card at address 000=
2
>> [  524.082596] mmcblk0: mmc0:0002 NCard 14.9 GiB
>> [  524.084240]  mmcblk0: p1
>> [  524.306434] FAT-fs (mmcblk0p1): utf8 is not a recommended IO charset =
for FAT
>> filesystems, filesystem will be case sensitive!
>
> I can't tell why those errors occur.  It would require more debugging.
> At least they don't seem to cause any serious problems.
>
>> With your patch applied, the initial errors messages (xhci_hcd 0000:00:1=
4.0: dev
>> 4 ep1out scatterlist error -104/-110) are not seen so far.
>
> This is because those errors occur when the device goes into runtime
> autosuspend and the computer tries to communicate with it while it is
> suspended.  Both things (the autosuspend and the communication attempt)
> are bugs in the drivers.
>
>> The device does reset (as you had mentioned), but it doesn't seem to hav=
e any
>> power drain related negative effects.
>>
>>
>> rrs@learner:~$ less /var/tmp/dmesg-post-patch.txt  | tail -n 25
>> [11922.283067] wlan0: RX AssocResp from 00:40:77:bb:55:12 (capab=3D0x411=
 status=3D0
>> aid=3D1)
>> [11922.283743] wlan0: associated
>> [11922.283801] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>> [11922.883849] systemd[1]: apt-daily.timer: Adding 8h 36min 18.323966s r=
andom
>> time.
>> [11923.081426] systemd[1]: apt-daily.timer: Adding 2h 23min 22.221062s r=
andom
>> time.
>> [13799.616838] atkbd serio0: Unknown key pressed (translated set 2, code=
 0xbe on
>> isa0060/serio0).
>> [13799.616843] atkbd serio0: Use 'setkeycodes e03e <keycode>' to make it=
 known.
>> [13799.625901] atkbd serio0: Unknown key released (translated set 2, cod=
e 0xbe
>> on isa0060/serio0).
>> [13799.625905] atkbd serio0: Use 'setkeycodes e03e <keycode>' to make it=
 known.
>> [13800.547966] usb 1-4: USB disconnect, device number 15
>
> Spontaneous disconnect followed by reconnect a little later...
>
>> [13801.707137] usb 1-4: new high-speed USB device number 16 using xhci_h=
cd
>> [13801.880788] usb 1-4: New USB device found, idVendor=3D0bda, idProduct=
=3D0129
>> [13801.880791] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D3
>> [13801.880792] usb 1-4: Product: USB2.0-CRW
>> [13801.880793] usb 1-4: Manufacturer: Generic
>> [13801.880794] usb 1-4: SerialNumber: 20100201396000000
>> [13802.809031] usb 1-4: USB disconnect, device number 16
>> [13803.390459] usb 1-4: new high-speed USB device number 18 using xhci_h=
cd
>> [13808.807084] usb 1-4: new high-speed USB device number 19 using xhci_h=
cd
>> [13808.980827] usb 1-4: New USB device found, idVendor=3D0bda, idProduct=
=3D0129
>> [13808.980831] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D3
>> [13808.980833] usb 1-4: Product: USB2.0-CRW
>> [13808.980834] usb 1-4: Manufacturer: Generic
>> [13808.980835] usb 1-4: SerialNumber: 20100201396000000
>> [14367.255033] usb 1-7: reset full-speed USB device number 5 using xhci_=
hcd
>> 2016-08-25 / 18:53:16 =E2=99=92=E2=99=92=E2=99=92  =E2=98=BA
>>
>> Note: These resets are seen without any card/adapter in the reader.
>
> The computer probably still wants to communicate with the reader, in
> order to check whether a card has been inserted.  In theory this
> shouldn't be necessary, because the card reader should perform a remote
> wakeup when a card is inserted or removed.  It might not support this
> feature, however -- although your "lsusb -v" output shows that it does
> support remote wakeup.
>
>> > As you mentioned above, there's another aspect to power management
>> > besides runtime PM, namely Link Power Management.  Perhaps the device
>> > can't handle LPM.
>> >
>> > You can test this by editing the usb_device_supports_lpm() routine in
>> > drivers/usb/core/hub.c.  If you make it always return 0 immediately,
>> > that will disable LPM for all USB devices.  If the spontaneous
>> > disconnects don't reappear, we'll have the answer.
>> >
>> > Alan Stern
>> >
>>
>>
>> I'll try this out on a new build and share my results again on this thre=
ad.
>>
>> As for the patch, will it qualify for inclusion into the mainline kernel=
 ?
>
> You mean the patch that disables autosuspend in the rtsx_usb driver?
> No, it's not a real solution.  We need to figure out why the device
> gets autosuspended every 3 seconds and fix that bug, not just eliminate
> all support for runtime PM.
>
> Alan Stern
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
