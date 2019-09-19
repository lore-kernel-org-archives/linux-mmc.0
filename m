From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
Date: Fri, 20 Sep 2019 09:17:30 +1000
Message-ID: <D422FEED-06F6-44BE-955F-90318693FD96@ellerman.id.au>
References: <20190918152748.GA21241@infradead.org> <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>
Cc: linux-mmc@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>, xen-devel@lists.xenproject.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 20 September 2019 6:33:50 am AEST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org>
>wrote:
>>
>> please pull the dma-mapping updates for 5.4.
>
>Pulled.
>
>> In addition to the usual Kconfig conflics where you just want to keep
>> both edits there are a few more interesting merge issues this time:
>>
>>  - most importanly powerpc and microblaze add new callers of
>>    dma_atomic_pool_init, while this tree marks the function static
>>    and calls it from a common postcore_initcall().  The trivial
>>    functions added in powerpc and microblaze adding the calls
>>    need to be removed for the code to compile.  This will not show up
>>    as a merge conflict and needs to be dealt with manually!
>
>So I haven't gotten the powerpc or microblaze pull requests yet, so
>I'm not able to fix that part up yet.
>
>Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
>remind me when they _do_ send those pull requests, since otherwise I
>may well forget and miss it. Without an actual data conflict, and
>since this won't show up in my build tests either, it would be very
>easy for me to forget.
>
>Micha[e]l, can you both please make sure to remind me?

Yeah I was aware of it, and will make sure to remind you in my pull request.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
