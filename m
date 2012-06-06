From: David Brown <davidb@codeaurora.org>
Subject: Re: [RFC/PATCH 1/1] mmc: block: Add MMC write packing statistics
Date: Wed, 6 Jun 2012 09:56:51 -0700
Message-ID: <20120606165651.GA15102@codeaurora.org>
References: <1338963389-3147-1-git-send-email-merez@codeaurora.org>
 <1338963389-3147-2-git-send-email-merez@codeaurora.org>
 <CA+NV+VknemgROF5DsSVJ8MDUEyMnrM_vtj66nUTKP6ZvxsF+ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+NV+VknemgROF5DsSVJ8MDUEyMnrM_vtj66nUTKP6ZvxsF+ag@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rahul Bedarkar <rpal143@gmail.com>
Cc: Maya Erez <merez@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 06, 2012 at 12:02:10PM +0530, Rahul Bedarkar wrote:

> > +static ssize_t mmc_wr_pack_stats_read(struct file *filp, char __us=
er *ubuf,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_=
t cnt, loff_t *ppos)
> > +{
> > + =A0 =A0 =A0 struct mmc_card *card =3D filp->private_data;
> > + =A0 =A0 =A0 struct mmc_wr_pack_stats *pack_stats;
> > + =A0 =A0 =A0 int i;

> Best practice is to initialize variables at the time of declaration,
> even if you initialize it before using. Many times we forget to do
> that and there could be logical errors.

gcc will often emit a warning if a variable is used before
initialization.  There seems to be a trend amongst kernel developers
to eschew redundant initializations, since they do actually generate
code.  In fact, there is a macro 'uninitialized_var(x)' to suppress
the warning from the compiler when it is incorrect, so that a variable
doesn't have to be initialized when not really needed.

Outside of the kernel, though, I would otherwise agree with you.

David

--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
