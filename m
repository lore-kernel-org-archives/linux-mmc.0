From: Ben Chuang <benchuanggli@gmail.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
Date: Thu, 19 Sep 2019 09:50:31 +0800
Message-ID: <CACT4zj8dyLWfQ5uDafwXxd7A09S522j1nQTGHV0p5gn8nUzbRQ@mail.gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com> <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org> <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Michael K. Johnson" <johnsonm@danlj.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 18, 2019 at 7:09 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> > I see that the first four patches made it into Linus's kernel
> > yesterday. Is there any chance of this final patch that actually
> > enables the hardware making it into another pull request still
> > intended for 5.4?  Waiting on additional acked-by on Ben's work
> > addressing all the review comments?
> >
> > Thanks.
> >
> > On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> Add support for the GL9750 and GL9755 chipsets.
> >>
> >> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> >> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> >> tuning flow for GL9750.
> >
>
> It is OK by me:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you. Also thanks to other people who have given me their comments.
Ben
