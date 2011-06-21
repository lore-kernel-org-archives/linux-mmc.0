From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5] ARM: mach-shmobile: ag5evm: SDHI requires waiting for idle
Date: Tue, 21 Jun 2011 12:37:56 -0400
Message-ID: <m2tybjrvh7.fsf@bob.laptop.org>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
	<1308610812-3479-6-git-send-email-horms@verge.net.au>
	<m2aadbtbbl.fsf@bob.laptop.org> <20110621162735.GL7920@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110621162735.GL7920@linux-sh.org> (Paul Mundt's message of
	"Wed, 22 Jun 2011 01:27:36 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 21 2011, Paul Mundt wrote:
> On Tue, Jun 21, 2011 at 12:10:22PM -0400, Chris Ball wrote:
>> On Mon, Jun 20 2011, Simon Horman wrote:
>> > Dependencies:
>> > 	"mmc: sdhi: Add write16_hook"
>> > 	"ARM: mach-shmobile: ag5evm: consistently name sdhi info structures"
>> 
>> Could I get your ACK for this one, so that I can merge patches 1/2/3/5
>> together via the MMC tree?
>> 
> Well, this has a dependency on 4/5 which I've already applied. I was
> simply going to wait for 1-3 to be merged via your tree and then roll in
> this last one on top of that. If you want to take them all that's ok too,
> git should be able to deal with any merge conflicts fine.

Ah, okay -- I've pushed 1-3 now to mmc-next for 3.1, you can take 4-5.

(I was thinking I should try to avoid requiring you to wait for Linus
to pull MMC before you can send sh to him.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
