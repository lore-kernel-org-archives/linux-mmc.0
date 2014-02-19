From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded
 irq handler
Date: Wed, 19 Feb 2014 09:43:22 +0000
Message-ID: <20140219094322.GR21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
 <20140218175703.GJ21483@n2100.arm.linux.org.uk>
 <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pratyush Anand <pratyush.anand@st.com>, Viresh Kumar <viresh.kumar@st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, spear-devel <spear-devel@list.st.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 19, 2014 at 11:43:19AM +0530, Viresh Kumar wrote:
> Adding ST people as well who have access to boards and are working on SPEAr.
> 
> On 18 February 2014 23:27, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > 1) You're controlling the card power GPIO via the insertion/removal
> >    interrupt handler?  What's wrong with using a vmmc regulator for
> >    that, which will be controlled via the MMC subsystem as required?
> 
> Haven't explored that earlier.. Maybe its possible but no idea.
> The requirements were like this:
> - We may or maynot need a GPIO for controlling power
> - If we need it, we may need to disable/enable power with card removal/
> insertion Or we may need to keep it enabled for ever..

So how is this any different from any other system which controls power to
the MMC/SD socket?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
