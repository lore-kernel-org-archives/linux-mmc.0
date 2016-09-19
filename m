From: Don Zickus <dzickus@redhat.com>
Subject: Re: RTS5227 errors on mount
Date: Mon, 19 Sep 2016 09:41:58 -0400
Message-ID: <20160919134158.GW98438@redhat.com>
References: <20160901214047.GV98438@redhat.com>
 <20160915151129.GM98438@redhat.com>
 <CAPDyKFoACQUieOP7CFpmJQPGS4DG-=bKobXhnqsvd_Y1vddt8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756055AbcISNmB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 09:42:01 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoACQUieOP7CFpmJQPGS4DG-=bKobXhnqsvd_Y1vddt8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Sat, Sep 17, 2016 at 11:03:55AM +0200, Ulf Hansson wrote:
> On 15 September 2016 at 17:11, Don Zickus <dzickus@redhat.com> wrote:
> > Hi Ulf,
> >
> > My emails to Micky seem to get blocked.  Is there a better person to contact
> > about the rts5227 chip?
> 
> Sorry, I don't know.
> 
> Do you think this is a regression? Care to do a bisect?

I can try bisecting but I don't think it is a regression.  The hardware does
recover correctly (aborts the transaction, reset the device, and retry).  I
was just trying to see if there was some incorrect calculations made when
setting voltage levels or other chip configurations.

But I don't have the specs to know how things are supposed to work.

For right now it is just an' error' message that appears in our log that I
was trying to get rid of.  I don't see any loss of data, which is good.

I was hoping Micky would just be able to give a quick answer or something.

I will poke at bisection to see if anything useful comes up.

Cheers,
Don
