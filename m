From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Thu, 15 Mar 2012 17:36:04 +0000
Message-ID: <4F622884.6060807@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-3-git-send-email-lee.jones@linaro.org> <20120315173256.GD15988@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51218 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031022Ab2CORgG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:36:06 -0400
Received: by eaaq12 with SMTP id q12so1773106eaa.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 10:36:05 -0700 (PDT)
In-Reply-To: <20120315173256.GD15988@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org, arnd@arndb.de

On 15/03/12 17:32, Russell King - ARM Linux wrote:
> On Wed, Mar 14, 2012 at 02:20:00PM +0000, Lee Jones wrote:
>> This is a step in the right direction for future Device
>> Tree support. It will allow variant specific attributes
>> to be collected from a Device Tree without overloading
>> the MMCI core. It will also provide additional future
>> variants a cleaner way to add support.
>=20
> NAK.  You can't have two driver structures with the same name.  The n=
ames
> are sysfs object names.

Well spotted.

I've already changed this in v2. :)

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
