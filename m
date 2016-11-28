From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH 2/5] smd: Make packet size a constant
Date: Mon, 28 Nov 2016 13:20:12 -0800
Message-ID: <20161128212012.GA12333@mini-rhel.redhat.com>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
 <1479863388-23678-3-git-send-email-jeremymc@redhat.com>
 <20161124061450.GV28340@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124061450.GV28340@tuxbot>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jeremy McNicoll <jeremymc@redhat.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, riteshh@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 23, 2016 at 10:14:50PM -0800, Bjorn Andersson wrote:
> On Tue 22 Nov 17:09 PST 2016, Jeremy McNicoll wrote:
> 
> > Use a macro to define the maximum size of a RPM message.
> > 
> 
> No thanks.
>

Sure, will drop this change with V2 in a few days so that people have a chance
to provide feedback. 

-jeremy
