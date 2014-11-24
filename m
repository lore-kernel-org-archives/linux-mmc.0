From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Mon, 24 Nov 2014 12:54:10 +0100
Message-ID: <CAPDyKFruGDj5z5+i6FLT2YHhKPvY6wFE98dBQYsJroCNST_fyw@mail.gmail.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
 <CAOEd-H2qbWgaauX=phfFk8HQqHk9gff3m_uoZqc+4Gbc6LZ-Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOEd-H2qbWgaauX=phfFk8HQqHk9gff3m_uoZqc+4Gbc6LZ-Lg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: Andy Green <andy.green@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Patch Tracking <patches@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 24 November 2014 at 11:45, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:
> 2014-11-24 17:54 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 21 November 2014 at 01:51, Vincent Yang
>> <vincent.yang.fujitsu@gmail.com> wrote:
>>> Hello,
>>>
>>>   Fujitsu have an sdhci IP which is implemented in a SoC we're
>>> adding to mainline, the most recent series for that was sent
>>> here:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html
>>>
>>>   These patches are against v3.18-rc5 mainline and tested on
>>> v3.18-rc5 integration tree.
>>>
>>>   We welcome any comment and advice about how to make any
>>> improvements or better align them with upstream.
>>
>> Apparently, there's a dependency between this patchset and the upper
>> one you refereed to. That's a problem.
>
> This patchset does not require anything from the upper one I refereed to.

No, but the upper depends on this patchset.

Why can't you send the mmc patches separately in one patchset? That's
would be easier to handle and review.

Kind regards
Uffe
