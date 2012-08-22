From: Loic pallardy <loic.pallardy@gmail.com>
Subject: Re: [PATCH v3 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Wed, 22 Aug 2012 09:43:26 +0200
Message-ID: <CAKGveeZrbBJObhpoMcdfw9DS4J9+w3MbxYX7qxVnJrgyUQ_x0w@mail.gmail.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	<1344265951-22437-6-git-send-email-loic.pallardy-ext@stericsson.com>
	<CAPM_RLb9P61E+DVQh6e_gFO5QtcVLbxmEPX4WBVO_XxHA=7Saw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58699 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab2HVHn1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 03:43:27 -0400
Received: by obbuo13 with SMTP id uo13so1036842obb.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Aug 2012 00:43:27 -0700 (PDT)
In-Reply-To: <CAPM_RLb9P61E+DVQh6e_gFO5QtcVLbxmEPX4WBVO_XxHA=7Saw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shashidhar hiremath <shashidar1887@gmail.com>
Cc: Loic Pallardy <loic.pallardy-ext@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>

>
>
> Hi,
>   Any specific reason why the RPMB support is implemented using the
> IOCTL interface. Can this be done by the Kernel itself instead of
> being initiated by a user space application ?
>
> --
> regards,
> Shashidhar Hiremath
> --

Hi,
There are several reasons for that:
- RPMB partition supports only few commands, it is not a "standard" partition
- RPMB data access requests a dedicated data frame which contains MAC,
write counter, address...
- Only trusted/secured applications owns authentification key to
calculate MAC (message authentification code) for each data frame.

So implementing RPMB access in kernel will complexify the driver (link
with security, data frame management...) and create vulnerability from
security point of view.
With this solution, kernel driver provides just a pipe between secured
application and eMMC.

Regards,
Loic
