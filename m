From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
Date: Tue, 6 Oct 2015 18:23:34 +0200
Message-ID: <20151006162334.GB3557@lunn.ch>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
 <20151006033131.GA24230@lunn.ch>
 <CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
 <20151006144523.GA32615@lunn.ch>
 <CAPv3WKfOkTHTSXqzZNr+-E20nHr40jqw_Dg6qz24uDa+nB5-BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPv3WKfOkTHTSXqzZNr+-E20nHr40jqw_Dg6qz24uDa+nB5-BA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory =?iso-8859-1?Q?Cl=E9ment?= <gregory.clement@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>
List-Id: linux-mmc@vger.kernel.org

> We have three options here:
> - leave GPIO-based card detection and see if in future anyone
> complains about not working detection
> - switch to DAT3 detection - yes you're right, that it is a regression
> for all boards < 1.5
> - enable SW polling for detection ("broken-cd") which should satisfy
> all kind of boards

Then i would suggest either broken-cd, or two .dtb blobs and good
comments in the dts files about how to identify the boards and what
happens if you run the wrong DTB blob.

     Andrew
