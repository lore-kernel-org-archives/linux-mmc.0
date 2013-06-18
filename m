From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] RFC: mmc: dw_mmc: Always go to STATE_DATA_BUSY from
 STATE_DATA_ERROR
Date: Tue, 18 Jun 2013 21:36:13 +0900
Message-ID: <001801ce6c20$6ba39900$42eacb00$%jun@samsung.com>
References: <1363382956-14557-1-git-send-email-dianders@chromium.org>
 <5146EAB0.1030705@samsung.com>
 <CAD=FV=Ww-iK=-vg4jnJe6w4836-yQUoUyxNvCYsDQ5w0q-OMMQ@mail.gmail.com>
 <515E88E3.5070507@samsung.com>
 <003401ce3453$19d1e8c0$4d75ba40$%jun@samsung.com>
 <CAD=FV=V+ZZ0MUtuWKUOgR9NPyAquUjFC6KtHvAP-4iHXAYpjqA@mail.gmail.com>
 <001601ce35b9$652c5870$2f850950$%jun@samsung.com>
 <CAD=FV=XKeRjpH1+ytjMfLuGGqQ5VVub22n=V+UpV=jBCD4LLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD=FV=XKeRjpH1+ytjMfLuGGqQ5VVub22n=V+UpV=jBCD4LLHw@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@gmail.com>, 'Bing Zhao' <bzhao@marvell.com>, 'Ashok Nagarajan' <asnagarajan@chromium.org>, 'Paul Stewart' <pstew@chromium.org>, 'Olof Johansson' <olof@lixom.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday, June 13, 2013, Doug Anderson wrote:
> Seungwon,
> 
> On Wed, Apr 10, 2013 at 12:02 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> > There are two solutions we have applied.
> >>
> >> I'm a little confused.  Have you already applied one or both of the
> >> solutions you list below, or are you proposing them as alternates to
> >> the patch I submitted?
> > Yes, first one already has been applied.
> > I wanted to introduce our fix. Did you try to test with these fixes?
> 
> I'm coming back to this after being quite distracted for a while.
> 
> I'm a little confused in that you said that your first fix was already
> applied.  I don't see it anywhere.  Did you mean that you've already
> applied it locally, or that it's applied in some git tree somewhere?
> If so, can you point me to it?
> 
> If this hasn't been sent out anywhere, perhaps you could send out
> official patches?
Currently, it has just applied for some projects, not official patch.
> 
> I don't have the failing unit myself, so we'll have to get Bing to try
> the patches.  You are suggesting that we try applying both of your
> patches, right?
Did you test the patch?
I wonder that both are good for your side.

Thanks,
Seungwon Jeon
> 
> -Doug
