From: James Nuss <jamesnuss@nanometrics.ca>
Subject: Re: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
Date: Wed, 10 Oct 2018 09:52:44 -0400
Message-ID: <CALgcdhhqvn3YWvQjtFfo46wH1N29-4vThNDzN1B2AROLY-kovw@mail.gmail.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
 <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avri.Altman@wdc.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 10, 2018 at 4:43 AM Avri Altman <Avri.Altman@wdc.com> wrote:
>
>
> > +++ b/mmc_cmds.c
> > @@ -1758,8 +1758,15 @@ int do_read_extcsd(int nargs, char **argv)
> >       }
> >
> >       if (ext_csd_rev >= 7) {
> > -             printf("eMMC Firmware Version: %s\n",
> > -                     (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> > +             printf("Firmware Version:
> > 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_5],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_4],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_3],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_2],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_1],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_0]);
> ExtCSD[261:254] is an ASCII string, just add a terminating null.

Unfortunately I found two different manufacturers which put
non-printable characters in this 8-byte field. So I don't think it can
be treated as ASCII in all cases. Printing out the hex value seemed
liked the most comprehensive solution.

>
> Thanks,
> Avri
>


--

-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
