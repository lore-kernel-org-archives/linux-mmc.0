From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 1/2] msm: Fix a typo in MSM SDCC driver gpio setup
Date: Mon, 22 Aug 2011 10:11:01 -0700
Message-ID: <20110822171101.GA6860@huya.qualcomm.com>
References: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
 <1313927564-10355-2-git-send-email-alexander.tarasikov@gmail.com>
 <20110822155041.GA4829@huya.qualcomm.com>
 <CAMChaFw+3yAoRiFEgdY8deL0+L7kRgt8T7y8ohTMwkN-xVMyHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMChaFw+3yAoRiFEgdY8deL0+L7kRgt8T7y8ohTMwkN-xVMyHg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Cc: David Brown <davidb@codeaurora.org>, dwalker@fifo99.com, bryanh@codeaurora.org, cjb@laptop.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 22, 2011 at 08:25:16PM +0400, Alexander Tarasikov wrote:
> 2011/8/22 David Brown <davidb@codeaurora.org>:
> > Both of your patches have somehow gotten mangled in transit (the
> > context lines have lost their leading space). =A0Did you perhaps ed=
it
> > the patch files with an editor that is configured to fold spaces in=
to
> > tabs?
> Sorry for that, it was my first attempt ever at sending patches, i'll
> try to do better the next time. I was using git send-email and vim fo=
r
> compose.

It's mostly important that when you edit a patch file, you make sure
that it doesn't change parts of the file that you aren't editing.

> > I was able to fix up the files and apply the patches, and will incl=
ude
> > these once Sahitya has a chance to review them.
> >
> Okay, thank you. Hope one day the rest of drivers (rpc, i2c, gpio,
> usb) get integrated and msm/qsd will be usable with vanilla kernel.

We're working on a lot of the stuff.  However, it is unlikely that
there will be much support for anything new on the msm7200 target.
I'm trying to keep the 8x50 going, but even that is hard to get people
interested in working on it.

David

--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
