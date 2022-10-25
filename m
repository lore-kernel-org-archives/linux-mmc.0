Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFCC04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJYRWm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiJYRWk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 13:22:40 -0400
X-Greylist: delayed 13588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 10:22:39 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975BE77BA
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 10:22:38 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Mxdzr6C86z9sls;
        Tue, 25 Oct 2022 19:22:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1666718552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cL5BqCrdtnzYankeC2nXkHEgyAYHcrWvWPnTDyeTow=;
        b=ZaZcQxKP7UjlNETo9LxeLOsmLgjBQLamT3g3VoCZS8JbnZA6lB/nciwQIp/+iY5OLFkbts
        CBj6XQyCM4c5KDtYahiP57ra5il3+cqRqirghvK0S0SmUl0jLi6k2Orl9R1RdktPjvFMuN
        PoRL9cs9AFwFBEgqX051RX2P3Q13Eogez4I3fe5hPib2BJ2Vzeo0SlayR9zivSQNnAbuW9
        zfk+oM4BWibYvUZc4KQ5v66iDuFE8L9V/IUH1epjSaUrNS9DOab7hr273Hdbg3MRake0mn
        Ua2EHbt4O70XTpLUlUQBgngQop6ZRHE4FV5Dr3dn1kVcc3KMyPsX4lhuY+jD7A==
Date:   Tue, 25 Oct 2022 19:22:28 +0200
From:   Andreas Radke <andreas.radke@mailbox.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: constant media change events - hardware or driver problem?
Message-ID: <20221025192228.022f1d5c@workstation64>
In-Reply-To: <534dfadc-5f68-df2a-6c85-c2c221d8c7e0@intel.com>
References: <20221025153602.3cacaae6@workstation64>
        <534dfadc-5f68-df2a-6c85-c2c221d8c7e0@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JjpregUVih1VFI=K/DtErcV";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-MBO-RS-ID: fd67771e9b7986572f3
X-MBO-RS-META: xrfqo771e3esri49rg3inqrymb5mudnf
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--Sig_/JjpregUVih1VFI=K/DtErcV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 25 Oct 2022 19:55:03 +0300
schrieb Adrian Hunter <adrian.hunter@intel.com>:

> On 25/10/22 16:36, Andreas Radke wrote:
>  [...] =20
>  [...] =20
>  [...] =20
>=20
> I may be misreading this, but the device causing the media change
> events seems to be:
>=20
> /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5.1/1-5.1:1.0/host2/target2:0=
:0/2:0:0:0/block/sdb
>=20
> and the driver is ums-realtek which is a USB Storage driver for
> "Realtek Card Reader support".
>=20
> In that case it does not involve the kernel mmc subsystem at all.
>=20
> As you listed above, there is an SD Host controller PCI device
> 00:10.0. Is there a reason to think that it is also involved?
>=20

lspci
00:00.0 Host bridge: Intel Corporation Atom/Celeron/Pentium Processor x5-E8=
000/J3xxx/N3xxx Series SoC Transaction Register (rev 21)
00:02.0 VGA compatible controller: Intel Corporation Atom/Celeron/Pentium P=
rocessor x5-E8000/J3xxx/N3xxx Integrated Graphics Controller (rev 21)
00:10.0 SD Host controller: Intel Corporation Atom/Celeron/Pentium Processo=
r x5-E8000/J3xxx/N3xxx Series MMC Controller (rev 21)
00:13.0 SATA controller: Intel Corporation Atom/Celeron/Pentium Processor x=
5-E8000/J3xxx/N3xxx Series SATA Controller (rev 21)
00:14.0 USB controller: Intel Corporation Atom/Celeron/Pentium Processor x5=
-E8000/J3xxx/N3xxx Series USB xHCI Controller (rev 21)
00:1a.0 Encryption controller: Intel Corporation Atom/Celeron/Pentium Proce=
ssor x5-E8000/J3xxx/N3xxx Series Trusted Execution Engine (rev 21)
00:1b.0 Audio device: Intel Corporation Atom/Celeron/Pentium Processor x5-E=
8000/J3xxx/N3xxx Series High Definition Audio Controller (rev 21)
00:1c.0 PCI bridge: Intel Corporation Atom/Celeron/Pentium Processor x5-E80=
00/J3xxx/N3xxx Series PCI Express Port #1 (rev 21)
00:1c.1 PCI bridge: Intel Corporation Atom/Celeron/Pentium Processor x5-E80=
00/J3xxx/N3xxx Series PCI Express Port #2 (rev 21)
00:1c.2 PCI bridge: Intel Corporation Atom/Celeron/Pentium Processor x5-E80=
00/J3xxx/N3xxx Series PCI Express Port #3 (rev 21)
00:1c.3 PCI bridge: Intel Corporation Atom/Celeron/Pentium Processor x5-E80=
00/J3xxx/N3xxx Series PCI Express Port #4 (rev 21)
00:1f.0 ISA bridge: Intel Corporation Atom/Celeron/Pentium Processor x5-E80=
00/J3xxx/N3xxx Series PCU (rev 21)
00:1f.3 SMBus: Intel Corporation Atom/Celeron/Pentium Processor x5-E8000/J3=
xxx/N3xxx SMBus Controller (rev 21)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 0c)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 0c)
04:00.0 Network controller: Intel Corporation Wireless 3160 (rev 83)

I had assumed it's the 00:10.0 device behaving weird here. Maybe it's actua=
lly the Realtek one here:

lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 8087:07dc Intel Corp. Bluetooth wireless interface
Bus 001 Device 003: ID 0bda:0153 Realtek Semiconductor Corp. 3-in-1 (SD/SDH=
C/SDXC) Card Reader
Bus 001 Device 002: ID 1a40:0101 Terminus Technology Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

No idea if they interact at all or how it works here. So the faulty device =
is only this one?

Bus 001 Device 003: ID 0bda:0153 Realtek Semiconductor Corp. 3-in-1 (SD/SDH=
C/SDXC) Card Reader
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0x0153 3-in-1 (SD/SDHC/SDXC) Card Reader
  bcdDevice           57.13
  iManufacturer           1 Generic
  iProduct                2 USB2.0-CRW
  iSerial                 3 20120926571200000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0020
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 CARD READER
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk-Only
      iInterface              5 Bulk-In, Bulk-Out, Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)


Is there anything I can do with some driver or module option of that usb de=
vice?=20

-Andy

--Sig_/JjpregUVih1VFI=K/DtErcV
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmNYG1QACgkQlGV6sg8q
CSsVmgf8CEEmpuH1k9219d0OkWqMCaNESX51ReuCIkoZV1oStIWnrwzB+rIpBnbp
uX7NtWbQ63ivV0ZoSXC5RmlLYnJZ/ASzZk/KQ1cR9TE4UFK17PN1MmxDeCc+4DPV
aYnsOaHseWXxoMUaELhaZT1r8dAEWtELwJuFslH+wLcrrr/uCNIYpVaFCNZg0wnq
ACpvaVAe5to6Fn/UuogMdzVlwLv15jVFnMw5aGZ9FyxyLShQ0XrQ3G9xcPQ/L7fg
pZhHUlZ7pbQJE/cdI6CdPHHXht7Cid0qcj16x8MqKr8uEV2A8znRLth6tOIG7H1F
9XQ/5asoHWdd5b646nVRMeL9ubVUeQ==
=Lizt
-----END PGP SIGNATURE-----

--Sig_/JjpregUVih1VFI=K/DtErcV--
