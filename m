From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 12:08:49 +0000
Message-ID: <201208211208.49987.arnd@arndb.de>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org> <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com> <87k3ws5uhs.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49640 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab2HUMJG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Aug 2012 08:09:06 -0400
In-Reply-To: <87k3ws5uhs.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org

On Tuesday 21 August 2012, Chris Ball wrote:
> How about this?
> 
> broken-cd: No CD available, use polling.
> 
> cd-gpios: The CD pin on the host is working and brought out to a GPIO.
> 
> external-cd-gpios: The CD pin on the host is broken, but there's an
>                    independent external GPIO available.
> 
> 
> (Each host should only have one of these properties.)

The fsl-imx-esdhc.txt binding already has all three cases, but
describes them differently:

fsl,cd-internal: when present, the CD pin on the host is working
cd-gpios: when present, contains the gpio line that CD is connected to
If both are absent, it has to use polling.

	Arnd
