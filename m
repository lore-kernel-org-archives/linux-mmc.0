From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Date: Tue, 29 Oct 2019 12:02:50 -0500
Message-ID: <20191029170250.GA43972@google.com>
References: <CAFjuqNihuEb4_5Lny5X7vA258c0ogemVg8pQ5Y_ANgOsqhSXhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFjuqNihuEb4_5Lny5X7vA258c0ogemVg8pQ5Y_ANgOsqhSXhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael ." <keltoiboy@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Trevor Jacobs <trevor_jacobs@aol.com>, Kris Cleveland <tridentperfusion@yahoo.com>, Jeff <bluerocksaddles@willitsonline.com>, Morgan Klym <moklym@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Philip Langdale <philipl@overt.org>, Pierre Ossman <pierre@ossman.eu>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

[+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
thread, [2] for problem report and the patch Michael tested]

On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
> Bjorn and Dominik.
> I am happy to let you know the patch did the trick, it compiled well
> on 5.4-rc4 and my friends in the CC list have tested the modified
> kernel and confirmed that both slots are now working as they should.
> As a group of dedicated Toughbook users and Linux users please accept
> our thanks your efforts and assistance is greatly appreciated.
> 
> Now that we know this patch works what kernel do you think it will be
> released in? Will it make 5.4 or will it be put into 5.5 development
> for further testing?

That patch was not intended to be a fix; it was just to test my guess
that the quirk might be related.

Removing the quirk solved the problem *you're* seeing, but the quirk
was added in the first place to solve some other problem, and if we
simply remove the quirk, we may reintroduce the original problem.

So we have to look at the history and figure out some way to solve
both problems.  I cc'd some people who might have insight.  Here are
some commits that look relevant:

  5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
  03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")


[1] https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
[2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
