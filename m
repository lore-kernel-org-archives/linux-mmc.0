From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Wed, 26 Jun 2013 10:53:37 +0900
Message-ID: <001001ce720f$f96980c0$ec3c8240$%jun@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
 <5146EAB0.1030705@samsung.com>
 <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
 <515E88E3.5070507@samsung.com>
 <003401ce3453$19d1e8c0$4d75ba40$%jun@samsung.com>
 <CAD=FV=V+ZZ0MUtuWKUOgR9NPyAquUjFC6KtHvAP-4iHXAYpjqA@mail.gmail.com>
 <001601ce35b9$652c5870$2f850950$%jun@samsung.com>
 <CAD=FV=XKeRjpH1+ytjMfLuGGqQ5VVub22n=V+UpV=jBCD4LLHw@mail.gmail.com>
 <001801ce6c20$6ba39900$42eacb00$%jun@samsung.com>
 <477F20668A386D41ADCC57781B1F70430EA2AA2513@SC-VEXCH1.marvell.com>
 <CAD=FV=Xz-Cp86u=w8m91AEMJgH-o6cLkz6_udVw_3bm7Tm0OiA@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F70430EA2AA251A@SC-VEXCH1.marvell.com>
 <CAD=FV=V6S7FsK+=+7EHDV74=Mw_iWecO2ZxVpVcd=p7ugW-sHA@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F70430EA2BD5ECB@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <477F20668A386D41ADCC57781B1F70430EA2BD5ECB@SC-VEXCH1.marvell.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Bing Zhao' <bzhao@marvell.com>, 'Doug Anderson' <dianders@chromium.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@gmail.com>, 'Ashok Nagarajan' <asnagarajan@chromium.org>, 'Paul Stewart' <pstew@chromium.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,
Do you have the same result?
Could you share the result?

Thanks,
Seungwon Jeon
On Tuesday, June 25 2013, Bing Zhao wrote:
> > I think the proposal on the table is to take Seungwon's patches
> > instead of mine.  Assuming they solve your problems, I'm OK with that.
> >  I think he was requesting testing the first of his two patches alone
> > and then both of his two patches together.
> 
> Test #1: Swungwon's patch #1 alone [1]
> Test #2: Swungwon's patch #2 alone [1]
> Test #3: Swungwon's patch #1 and #2 [1]
> Test #4: Doug's original patch [2]
> 
> Test #1 and #3: it doesn't work; system reboots due to kernel hung_task
> Test #2 and #4: it works; instead of hung_task driver gets CRC error (which is expected)
> 
> Thanks,
> Bing
> 
> [1] https://lkml.org/lkml/2013/4/8/316
> [2] https://lkml.org/lkml/2013/3/15/583
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
