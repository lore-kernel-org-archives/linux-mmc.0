From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt: bindings: Make compatible optional for mmc function nodes
Date: Sat, 16 Jul 2016 15:38:45 -0500
Message-ID: <CAL_JsqJX1a=TFgYUT+rAZfhZkFRfwer_VRuSEAJdD=dPYoP62w@mail.gmail.com>
References: <1468700175-31836-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59486 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbcGPUjI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Jul 2016 16:39:08 -0400
In-Reply-To: <1468700175-31836-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, devicetree <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Sat, Jul 16, 2016 at 3:16 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> mmc/sdio is an enumerable bus, so usually the os can find out which
> device is attached without needing a compatible.

Usually, yes, but always, no. Having it doesn't hurt either, so this
is a NAK for me.

>
> Sometimes it is desirable to have a mmc function node, without having
> to make up an otherwise unused compatible for the node, so make
> the compatible properties optional.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
