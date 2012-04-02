From: Rik van Riel <riel@redhat.com>
Subject: Re: swap on eMMC and other flash
Date: Mon, 02 Apr 2012 12:51:49 -0400
Message-ID: <4F79D925.7070900@redhat.com>
References: <201203301744.16762.arnd@arndb.de> <201203301850.22784.arnd@arndb.de> <alpine.LSU.2.00.1203311230490.10965@eggly.anvils> <26E7A31274623843B0E8CF86148BFE326FB55F8B@NTXAVZMBX04.azit.micron.com> <alpine.LSU.2.00.1204020754180.1847@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LSU.2.00.1204020754180.1847@eggly.anvils>
Sender: owner-linux-mm@kvack.org
To: Hugh Dickins <hughd@google.com>
Cc: "Luca Porzio (lporzio)" <lporzio@micron.com>, Arnd Bergmann <arnd@arndb.de>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Alex Lemberg <alex.lemberg@sandisk.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saugata Das <saugata.das@linaro.org>, Venkatraman S <venkat@linaro.org>, Yejin Moon <yejin.moon@samsung.com>, Hyojin Jeong <syr.jeong@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>
List-Id: linux-mmc@vger.kernel.org

On 04/02/2012 10:58 AM, Hugh Dickins wrote:
> On Mon, 2 Apr 2012, Luca Porzio (lporzio) wrote:
>>
>> Great topics. As per one of Rik original points:
>>
>>> 4) skip writeout of zero-filled pages - this can be a big help
>>>      for KVM virtual machines running Windows, since Windows zeroes
>>>      out free pages;   simply discarding a zero-filled page is not
>>>      at all simple in the current VM, where we would have to iterate
>>>      over all the ptes to free the swap entry before being able to
>>>      free the swap cache page (I am not sure how that locking would
>>>      even work)
>>>
>>>      with the extra layer of indirection, the locking for this scheme
>>>      can be trivial - either the faulting process gets the old page,
>>>      or it gets a new one, either way it'll be zero filled
>>>
>>
>> Since it's KVMs realm here, can't KSM simply solve the zero-filled pages problem avoiding unnecessary burden for the Swap subsystem?
>
> I would expect that KSM already does largely handle this, yes.
> But it's also quite possible that I'm missing Rik's point.

Indeed, KSM handles it already.

However, it may be worthwhile for non-KVM users of transparent
huge pages to discard zero-filled parts of pages (allocated by
the kernel to the process, but not used memory).

Not just because it takes up swap space (writing to swap is
easy, space is cheap), but because not swapping that memory
back in later (because it is not used) will prevent us from
re-building the transparent huge page...

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
