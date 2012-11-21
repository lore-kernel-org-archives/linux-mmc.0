From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL v2] at91: fixes for 3.7-rc7
Date: Tue, 20 Nov 2012 23:03:03 -0800
Message-ID: <20121121070303.GD7615@quad.lixom.net>
References: <50AA5ED5.8090901@atmel.com>
 <CAOesGMjAYtEkmEYnzCQ4G821BWG9D6LHvgt5aOMJgus_hzFkRA@mail.gmail.com>
 <50AA6C76.3000606@atmel.com>
 <50AB466F.5010500@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50AB466F.5010500@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,


On Tue, Nov 20, 2012 at 09:59:27AM +0100, Nicolas Ferre wrote:
> Arnd, Olof,
> 
> Just for the record, I do not want to put pressure at a such late time in
> the 3.7-rc process. So, I just reworked that pull-request because the previous
> one was wrong:
> - wrong patch content (DT nodes with wrong size)
> - not all tags in patches (Jean-Christophe and Arnd tags were missing...)
> 
> Just to start from a sane base if I have to rebase this work for 3.8, I let you know
> that I have updated this tag...
> 
> The following changes since commit 641f3ce64b050961d454a0716bb6dbf528315aac:
> 
>   ARM: at91/usbh: fix overcurrent gpio setup (2012-11-16 10:46:29 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes

The new patches seem to belong in an at91/dt branch, not in a fixes one.

I can pull in the previous fixes branch as an at91/fixes-non-critical for 3.8
if you want. There's no need to rebase them for this, is there? What is the
pinctrl dependency that you are talking about, are some of these patches needed
as prerequisites for pinctrl changes or the other way around?

Sorry if I've missed more elaborate emails on this and are asking repeat
questions. ;)

-Olof
