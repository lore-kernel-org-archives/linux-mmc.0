From: Linus WALLEIJ <linus.walleij@stericsson.com>
Subject: RE: [PATCH] mmci: drop superfluous regulator #ifdef
Date: Fri, 10 Dec 2010 10:30:05 +0100
Message-ID: <CEE6BB42CAD6E947908279175AF8470A075EE07B17@EXDCVYMBSTM006.EQ1STM.local>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
	<20101210033908.GA4455@void.printf.net>
	<20101210081202.GA19186@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101210081202.GA19186@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

[Russell]
> [Chris]
>
> > Thanks, pushed to mmc-next for .38.
> 
> Also queued in the ARM tree.

Chris, Russell is listed as maintainer for this driver so
he probably prefers to take in changes to it through the ARM
tree, can you take this patch out of the mmc tree?

Yours,
Linus Walleij
