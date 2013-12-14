From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
Date: Sun, 15 Dec 2013 00:39:46 +0100
Message-ID: <201312150039.46681.arnd@arndb.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com> <201312142006.26979.arnd@arndb.de> <1387049660.7152.317.camel@host5.omatika.ru>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1387049660.7152.317.camel@host5.omatika.ru>
Sender: linux-doc-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Saturday 14 December 2013, Sergei Ianovich wrote:
> On Sat, 2013-12-14 at 20:06 +0100, Arnd Bergmann wrote:
> > On Friday 13 December 2013, Sergei Ianovich wrote:
> > > Non-dts implementation supply required DMA channel numbers as
> > > IORESOURCE_DMA. However, there is was no way to get them from
> > > device tree.
> > 
> > Please update this changeset comment, I think it still refers to
> > the earlier version.
> 
> ---
> Non-dts implementation supply required DMA channel numbers as
> IORESOURCE_DMA. We can also get them from the device tree, if it
> is present.
> ---
> 
> Is this fine?

I would mention that the binding is designed to work with the dmaengine
framework as soon as we have figured out how to make that work without
the problems you found.

> Should I post v3, if so? 

I'd wait a little longer for more comments.

	Arnd
