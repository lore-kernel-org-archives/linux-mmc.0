From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix card threshold control configuration
Date: Sun, 15 Jul 2018 13:31:04 -0700
Message-ID: <CA+55aFxONTOE8A+Mm=V2mieqnJ=Zypvu+NJeede2aR7kLu5SMA@mail.gmail.com>
References: <1530601587-160436-1-git-send-email-xiaqing17@hisilicon.com> <CAPDyKFrPw63KD5mESDmm2pya6bsz01jHiKguMP1GPhWDDZ644Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrPw63KD5mESDmm2pya6bsz01jHiKguMP1GPhWDDZ644Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: xiaqing17@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>, Evgeniy.Didin@synopsys.com, shawn.lin@rock-chips.com, Douglas Anderson <dianders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 3, 2018 at 2:00 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 3 July 2018 at 09:06, Qing Xia <xiaqing17@hisilicon.com> wrote:
> > From: x00270170 <xiaqing17@hisilicon.com>
> >
> > Card write threshold control is supposed to be set since controller
>> [..]
> > Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
>
> Thanks, applied/moved to fixes for 4.18!

.. and during making my 4.18-rc5 announcement, I saw the odd name in
the shortlog.

Now Qing Xia is forever attributed as "x00270170". Very odd.

Oh well.

                Linus
