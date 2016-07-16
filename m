From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt: bindings: Make compatible optional for mmc function nodes
Date: Sat, 16 Jul 2016 17:01:00 -0500
Message-ID: <CAL_JsqJvkFkgOJrku1qS9jfW5TvL6OvJozKGnc8KAytN7q3kEw@mail.gmail.com>
References: <1468700175-31836-1-git-send-email-hdegoede@redhat.com> <CAL_JsqJX1a=TFgYUT+rAZfhZkFRfwer_VRuSEAJdD=dPYoP62w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34992 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbcGPWBW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Jul 2016 18:01:22 -0400
In-Reply-To: <CAL_JsqJX1a=TFgYUT+rAZfhZkFRfwer_VRuSEAJdD=dPYoP62w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, devicetree <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Sat, Jul 16, 2016 at 3:38 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Sat, Jul 16, 2016 at 3:16 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> mmc/sdio is an enumerable bus, so usually the os can find out which
>> device is attached without needing a compatible.
>
> Usually, yes, but always, no. Having it doesn't hurt either, so this
> is a NAK for me.

Having now read the generic ethernet device binding thread, I think
the reasoning is okay, but please put those reasons here.

Rob
