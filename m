From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] mmc: tmio-mmc: add support for 32bit data port
Date: Mon, 3 Jul 2017 16:31:32 +0300
Message-ID: <20170703133132.rrwn6kmnyvjhxeo3@mwanda>
References: <20170629125446.2b5ruac5fev7lqp4@mwanda>
 <SG2PR06MB1165CBAC1354D2E62C3B3FBE8AD20@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165CBAC1354D2E62C3B3FBE8AD20@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 29, 2017 at 04:02:11PM +0000, Chris Brandt wrote:
> Personally, I think a buffer of raw data should be a 'u8 *', not a 
> 'unsigned short *'.

That works, or you could make it a void pointer.  (void *)foo + x and
(u8 *)foo + x are equivalent in kernel code.

> And, the parameter name "count" should really be something like "size" 
> or "length" (but that is still confusing because the passed array 'buf' 
> was designated as an array of "unsigned short *", so what would 'size' 
> really mean??)
> 
> Anyway, that is the API that's in place today, so that's what I needed 
> to work with.

You can change it.  This is the kernel so you can change anything if it
makes sense.

> 
> 
> > 
> >    417                  else
> >    418                          sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT,
> > (u32 *)buf,
> >    419                                              count >> 2);
> >    420
> >    421                  /* if count was multiple of 4 */
> >    422                  if (!(count & 0x3))
> >    423                          return;
> >    424
> >    425                  buf8 = (u8 *)(buf + (count >> 2));
> > 
> > 
> > And this looks like the bug...  buf is a u16 pointer but we're adding
> > "count / sizeof(u32)" when we should be adding "count / (sizeof(*buf))".
> 
> I agree this math does not work out to what I wanted because of the 
> differences in data types.
> 
> Since I simply wanted to get a pointer to where I left off in the 
> buffer, maybe the most clear thing to do is just cast buf and do simple math:
> 
>    buf8 = (u8 *)buf + (count & ~3);
> 
> 
> Do you agree?

Sure.  Unless you want to round up?

regards,
dan carpenter
