From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use module_platform_driver()
Date: Fri, 2 Dec 2011 09:11:00 +0800
Message-ID: <CAF+7xWn_FNFtOEzbyfV23DUBEpQy0zSVHrotysWb_YDmuaPQng@mail.gmail.com>
References: <1322283343.14278.2.camel@phoenix> <87borsjeez.fsf@laptop.org> <CAF+7xWnf+wK8EBoGZWNr=9R+WbuAMZbdjjPCP4cubNw8xLyudw@mail.gmail.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF+7xWnf+wK8EBoGZWNr=9R+WbuAMZbdjjPCP4cubNw8xLyudw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

2011/12/2 Axel Lin <axel.lin@gmail.com>:
> 2011/12/2 Chris Ball <cjb@laptop.org>:
>> Hi Axel, Micha,
>>
>> On Fri, Nov 25 2011, Axel Lin wrote:
>>> This patch converts the drivers in drivers/mmc/host/* to use the
>>> module_platform_driver() macro which makes the code smaller and a b=
it
>>> simpler.
>>
>> This makes cb710_mmc unhappy:
>>
>> /home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:783:1: warning: data =
definition has no type or storage class [enabled by default]
>> /home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:783:1: warning: type =
defaults to =91int=92 in declaration of =91module_platform_driver=92 [-=
Wimplicit-int]
>> /home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:783:1: warning: param=
eter names (without types) in function declaration [enabled by default]
>> /home/cjb/git/mmc/drivers/mmc/host/cb710-mmc.c:773:31: warning: =91c=
b710_mmc_driver=92 defined but not used [-Wunused-variable]
>
> Strange. I don't see above warning in my build after apply this patch=
=2E
> ( Tested on linux-next tree ).
>
I found the problem now.
It is because the define of module_platform_driver does not exist in
your mmc-next branch.
However, it does exist in your master branch. ( see
include/linux/platform_device.h )

Axel
