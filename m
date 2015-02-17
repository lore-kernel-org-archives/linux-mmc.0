From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: SDIO - High Speed - iMX6
Date: Tue, 17 Feb 2015 11:17:49 -0800
Message-ID: <CACUGKYOJgMZ28esgFnGt1uQc5VDCfvcoUpgk5KACVb1Fiqz-Uw@mail.gmail.com>
References: <CACUGKYNPE1zAHt4Hx4c5ufuHNchVXnUOC1znCa7dT9povD_CWQ@mail.gmail.com>
	<CAOMZO5DR2nnoChgC2PbXkrDCAfF0WG_Vf+iXR3UsfFGxQxagmA@mail.gmail.com>
	<CACUGKYMJm7qTLHBJwH=58mhpcJBePPgOKt96cw1XECX2ozPwuQ@mail.gmail.com>
	<CAOMZO5DRUo+wKR76ywdAA-NjojjR08hirjZ0Ru8PNdx19giVEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:39513 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbbBQTRv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Feb 2015 14:17:51 -0500
Received: by labgq15 with SMTP id gq15so37853020lab.6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2015 11:17:49 -0800 (PST)
In-Reply-To: <CAOMZO5DRUo+wKR76ywdAA-NjojjR08hirjZ0Ru8PNdx19giVEw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Fabio,

In order NOT to permit the SDIO core controller to communicate in 3.3v
signal voltage, you need to define the vqmmc, voltage-ranges and vmmc
(see the example below).
I've tested this settings on 3.19 kernel and able to backport on 3.13.


wlan_en_reg: fixedregulator {
        compatible = "regulator-fixed";
        regulator-name = "wlan-en-regulator";
        regulator-min-microvolt = <1800000>;
        regulator-max-microvolt = <1800000>;

        enable-active-high;
        regulator-always-on;
    };

    reg_1p8v: 1p8v {
        compatible = "regulator-fixed";
        regulator-name = "1p8v";
        regulator-min-microvolt = <1800000>;
        regulator-max-microvolt = <1800000>;
    };

/* WiLink8 WIFI module */
&usdhc2 {
    status = "okay";
    vmmc-supply = <&wlan_en_reg>;
    vqmmc-supply = <&reg_1p8v>;
    voltage-ranges = <1800 1800>;

};

Regards,

John


On Tue, Feb 17, 2015 at 10:59 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Feb 15, 2015 at 4:54 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hi Fabio,
>>
>> I was able to work it.
>
> Care to share the solution?
