From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH] mmc: dt: Add property for broken hs200 quirk
Date: Mon, 29 Dec 2014 14:37:39 -0800
Message-ID: <20141229223739.GB25436@sonymobile.com>
References: <1418412516-10682-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAPDyKFrPC_MphsLHHZ=uFjcF8SsdkVmzez9R=gas7_ihn63Q5A@mail.gmail.com>
 <CAJAp7OhSZ7CZedXAsWPf0XYv8RESQxXe4L1LZjOmVW4nGpFiHw@mail.gmail.com>
 <CAPDyKFoGN49usQg5Ezv_AaWcKf3mRmZ=VJ8Rc4HDYh62ukiwXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoGN49usQg5Ezv_AaWcKf3mRmZ=VJ8Rc4HDYh62ukiwXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Anton Vorontsov <anton@enomsg.org>, Chris Ball <chris@printf.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon 22 Dec 02:04 PST 2014, Ulf Hansson wrote:

> On 19 December 2014 at 21:01, Bjorn Andersson <bjorn@kryo.se> wrote:
> > On Fri, Dec 19, 2014 at 3:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 12 December 2014 at 20:28, Bjorn Andersson
> >> <bjorn.andersson@sonymobile.com> wrote:
> >>
> >> Some more explanation to why this needed would be good.
> >>
> >
> > Because (according to the git log) some of the memories that we
> > mounted in Xperia Z1 does not support HS200 even though they advertise
> > they are.
> 
> I see. How about using an mmc card quirk instead of a DT binding then?
> 

I've missed the fact that you can have card specific quirks as well, that looks
more sound than having to specify it separately in dt.

Let's drop this and I'll see if I can find some details about what memory this
might have been so I can add such a quirk. If I can find the information I'll
give it a try and send you a new patch.

Regards,
Bjorn
