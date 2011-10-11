From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: mmc core broken dependency on CONFIG_BLOCK (Was: linux-next:
 Tree for Oct 11 (mmc))
Date: Tue, 11 Oct 2011 14:59:34 -0700
Message-ID: <4E94BC46.5080505@xenotime.net>
References: <1172297901.46681.1318361517579.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1172297901.46681.1318361517579.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-next-owner@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-mmc@vger.kernel.org

On 10/11/11 12:31, Andrei Warkentin wrote:
> Hi Randy,
> 
> ----- Original Message -----
>> From: "Randy Dunlap" <rdunlap@xenotime.net>
>> To: "Stephen Rothwell" <sfr@canb.auug.org.au>
>> Cc: linux-next@vger.kernel.org, "LKML" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, "Chris Ball"
>> <cjb@laptop.org>
>> Sent: Tuesday, October 11, 2011 2:49:39 PM
>> Subject: Re: linux-next: Tree for Oct 11 (mmc)
>>
>> On 10/11/11 02:11, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> The linux-next tree is now available from
>>> git://github.com/sfrothwell/linux-next.git as a temporary measure
>>> while
>>> the kernel.org servers are unavailable.
>>>
>>> It may also turn up on git.kernel.org (depending on the mirroring).
>>>  The
>>> patch set is still absent, however.
>>>
>>> Changes since 20111007:
>>
>>
>> When CONFIG_BLOCK is not enabled:
>>
>> In file included from
>> next-2011-1011/drivers/mmc/card/sdio_uart.c:43:0:
>> next-2011-1011/include/linux/mmc/card.h:175:12: error:
>> 'DISK_NAME_LEN' undeclared here (not in a function)
>>
>> Deleting the #include <linux/mmc/card.h> fixes the sdio_uart.c build.
>> However, the same problem occurs in mmc/core/core.c:
>>
> 
> Because linux/genhd is now included, oops. I'm pretty positive this is due to the "mmc : general purpose partition support" patch pulled recently. I am adding NamJae, who was the author.
> 
>> In file included from next-2011-1011/drivers/mmc/core/core.c:30:0:
>> next-2011-1011/include/linux/mmc/card.h:175:12: error:
>> 'DISK_NAME_LEN' undeclared here (not in a function)
>>
>> Should mmc/core/ depend on BLOCK?  or should it just be made
>> to build even when BLOCK is not enabled?
>>
> 
> I don't think there should be a direct dependency on BLOCK. I have two suggestions -
> 1) Have our own define similar to (and in fact smaller):
>    linux/genhd.h:#define DISK_NAME_LEN                     32
> 2) Put the MMC physical partition code under an #ifdef CONFIG_BLOCK, which is a reasonable
>    proposition, given that there wouldn't be any need to parse physical partition info if
>    it would never be consumed by the MMC block driver.
> 
> Thoughts?

Agreed on part 2).  Do part 1) if it is required, but it's usually better
not to duplicate constants or structs etc.
IOW, can DISK_NAME_LEN in linux/genhd.h be exposed even when CONFIG_BLOCK
is not enabled?



-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
