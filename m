From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Thu, 16 Jun 2011 22:14:10 +0200
Message-ID: <201106162214.11084.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
	<201106141610.42700.heiko@sntech.de>
	<BANLkTimzxUQnVn5VC8EOaJeHq=wifUhZ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTimzxUQnVn5VC8EOaJeHq=wifUhZ4A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am Dienstag 14 Juni 2011, 22:32:41 schrieb Andrei Warkentin:
> Hi Heiko,
> =

> On Tue, Jun 14, 2011 at 9:10 AM, Heiko St=FCbner <heiko@sntech.de> wrote:
> > nope, no updates yet. The flood also only starts when udev wants to
> > create its device nodes, meaning the initial detection seems not to
> > produce this problem
> > =

> > But when I disable the whole boot partition stuff, it works as before
> > without irq storms.
> > =

> > As there don't seem to exist reports from other emmc users about this
> > I guess the problem lays somewhere between the boot-partitions-patch
> > and the sdhci-s3c driver (for s3c2416 at least).
> =

> Alright. Curious. Can you let me know what eMMC device you are
> connecting to the controller? What is the eMMC revision?
hmm ... how do I find these?
The real device providing the storage is a 2GB NAND Flash from Hynix.

And sadly both of your patches didn't change anything.

I made two interessting observations:
during boot the initial detection works ok - I can even mount the normal =

partitions without hickup when I stop it before the udev stage.

The irq storm seems to be caused by something udev does during its populati=
on =

of the /dev filesystem.

And second the mentioned irq storm never stops during the runtime of the =

device. When I let it boot through it spews what must be millions of the ir=
q =

messages and does so until I shut it down.

Heiko
