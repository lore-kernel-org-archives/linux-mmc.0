From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: Handle late vmmc regulators with
 EPROBE_DEFER
Date: Fri, 7 Jun 2013 11:14:44 -0700
Message-ID: <CAD=FV=WOWk==gjnuEwZfywU2Wxccj7AbSVNj_zuF0bnn8uDf4w@mail.gmail.com>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
 <1370626110-1731-1-git-send-email-dianders@chromium.org>
 <2536139.bTRcfOkXer@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <2536139.bTRcfOkXer@flatron>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Tomasz,

On Fri, Jun 7, 2013 at 10:42 AM, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> A question just out of curiousity: Is it really correct to have one vmmc
> regulator for the whole device, instead of one regulator per slot?
>
> This might be something obvious, but I don't know any details about
> dw_mmc, so sorry if it's the case.

I don't actually know.  I've never seen a multi-slot implementation so
I end up doing lots of speculation when I make changes.  Certainly the
code I'm moving wouldn't have worked correctly in the
more-than-one-slot case.  There's only space to pass one regulator
(it's not per-slot) and that one regulator would have just been
enabled multiple times.  ...and it would have only been disabled once
in places like suspend/resume.

If there is every a multi-slot implementation that needs vmmc on a
per-slot it seems like we could address at that time?

Thanks!

-Doug
