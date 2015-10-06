From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
Date: Tue, 6 Oct 2015 18:20:50 +0200
Message-ID: <20151006162050.GA3557@lunn.ch>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
 <20151006033131.GA24230@lunn.ch>
 <CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
 <8737xo9gvx.fsf@free-electrons.com>
 <CAPv3WKebE9SHd25mDbn+y4f0awseo_KXA9-aFgUNHTty4KxGFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPv3WKebE9SHd25mDbn+y4f0awseo_KXA9-aFgUNHTty4KxGFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>
List-Id: linux-mmc@vger.kernel.org

> My first feeling is that creating brand new dts just for sdhci
> detection (afaik there are no other bigger modifications of the PCB)
> is not the best idea. However maybe changing armada-388-gp.dts to dtsi
> and then add two single-entries' dts files on top is an option?

Yes, that is the correct way to do this, if we decide to have two DT
blobs for different hardware versions.

      Andrew
